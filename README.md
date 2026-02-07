# Terraform AWS 多环境基础设施模板

这是一个可直接落地的 Terraform 项目结构，覆盖 dev/test/prod 三个环境，并将 AWS 资源按模块（VPC、EC2、S3）拆分复用，既适合作为面试展示，也能在实际工作中快速扩展使用。

## 目录结构

```
terraform-aws-project/
  environments/
    dev/
    test/
    prod/
  modules/
    vpc/
    ec2/
    s3/
  examples/
    single-env/
```

## 模块说明

- `modules/vpc`：创建 VPC、公共子网、IGW、路由表与关联。
- `modules/ec2`：创建安全组与 EC2 实例（支持多实例、支持 IMDSv2，默认 `metadata_http_tokens = "optional"`、AMI 自动发现或手动指定）。
- `modules/s3`：创建 S3 Bucket（默认开启版本控制、加密、公共访问阻断与所有权控制）。

## 快速开始（以 dev 为例）

1) 进入环境目录
```bash
cd environments/dev
```

2) 准备变量文件
```bash
cp terraform.tfvars.example terraform.tfvars
```

3) 初始化并部署
```bash
terraform init
terraform fmt -check
terraform validate
terraform plan  -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

4) 查看输出
```bash
terraform output
```

5) 销毁资源
```bash
terraform destroy -var-file=terraform.tfvars
```

## 环境差异建议

| 环境 | 默认 region | 默认 instance_count | 默认状态后端 |
| --- | --- | --- | --- |
| dev | `us-east-1` | `1` | `local` |
| test | `us-east-1` | `1` | `local` |
| prod | `us-west-2` | `2` | `s3`（配合 DynamoDB 锁） |

- **dev/test**：使用较小实例规格与较少节点，便于节省成本；默认本地状态，协作可后续切换远端。
- **prod**：建议使用更高规格并开启多实例；SSH 入口建议限制到固定公网 IP；S3 可切换到 KMS 加密；远端状态建议使用 S3 + DynamoDB。

## 生产环境远端状态（prod）

先在 AWS 中准备远端状态所需资源（S3 bucket + DynamoDB 锁表）：

```bash
aws s3api create-bucket \
  --bucket your-terraform-state-bucket \
  --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2

aws dynamodb create-table \
  --table-name terraform-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-west-2
```

然后在 `prod` 环境初始化 backend：

```bash
cd environments/prod
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
```

## 生产实践建议（可选增强）

- 为 Terraform 执行身份配置最小权限 IAM 策略，仅保留当前项目需要的资源权限。
- 将 SSH 白名单限制在固定 CIDR（生产中禁止 `0.0.0.0/0`）。
- 使用 AWS SSM（配合 IAM Instance Profile）替代 SSH 登录。
- 为 S3 启用 KMS 加密（`s3_sse_algorithm = "aws:kms"`）。
- 按环境/账号隔离（dev/test/prod 使用不同 AWS 账号）。
- 生产环境建议强制 IMDSv2：`metadata_http_tokens = "required"`。

## 常见故障排查

- `BucketAlreadyExists`：`s3_bucket_name` 需要全局唯一，请更换名称后重新 `plan/apply`。
- `NoCredentialProviders` 或认证失败：检查 AWS 凭证来源（`aws configure`、环境变量、OIDC/角色）。
- `InvalidClientTokenId` / 权限不足：确认账号、region 与 IAM 权限是否匹配当前环境。
- backend region 不一致：`backend.hcl` 的 `region` 必须与 state bucket 所在 region 一致。
- `Error acquiring the state lock`：确认没有其他 Terraform 进程占锁，必要时用 `terraform force-unlock <LOCK_ID>` 处理。

## 示例

`examples/single-env` 提供单环境快速体验用法，适合演示或验证模块效果。
