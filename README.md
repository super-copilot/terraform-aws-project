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
- `modules/ec2`：创建安全组与 EC2 实例（支持多实例、默认启用 IMDSv2、AMI 自动发现或手动指定）。
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
terraform plan  -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

5) 销毁资源
```bash
terraform destroy -var-file=terraform.tfvars
```

## 环境差异建议

- **dev/test**：使用较小实例规格与较少节点，便于节省成本；默认本地状态，协作可后续切换远端。
- **prod**：建议使用更高规格并开启多实例；SSH 入口建议限制到固定公网 IP；S3 可切换到 KMS 加密；远端状态建议使用 S3 + DynamoDB。

## 生产环境远端状态（prod）

```bash
cd environments/prod
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
```

## 生产实践建议（可选增强）

- 将 SSH 白名单限制在固定 CIDR（生产中避免 0.0.0.0/0）。
- 使用 AWS SSM（配合 IAM Instance Profile）替代 SSH 登录。
- 为 S3 启用 KMS 加密（`s3_sse_algorithm = "aws:kms"`）。
- 按环境/账号隔离（dev/test/prod 使用不同 AWS 账号）。
- 如需强制 IMDSv2，可设置 `metadata_http_tokens = "required"`（默认不强制）。

## 示例

`examples/single-env` 提供单环境快速体验用法，适合演示或验证模块效果。
