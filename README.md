# Terraform AWS 基础架构模版[[1](https://www.google.com/url?sa=E&q=https%3A%2F%2Fvertexaisearch.cloud.google.com%2Fgrounding-api-redirect%2FAUZIYQEZcEcb__rKTpIq2CF68EZodJnLl6RB3ZFZg-mh5GskzmzOn20cRaM8VLSWf94YGFzNY3P3ku12HLRPXky4VM-XBJcNk4j3bwFCZNAw-N_N_QFHjOIkX5su8U0DHHZVbZdByoAUfBrzEu9L1WuE0qlIhVkyBHMmc7sn8_aH2ZRS6Faq-2tBM3StUQ%3D%3D)]

> 由于原帐户无法找回登陆, 所以对repositories进行重新整理和迁移

这是一个基于 Terraform 的模块化 AWS 基础架构模板。它会自动创建一个标准的网络环境（VPC）并在其中部署一个 EC2 实例。[[1](https://www.google.com/url?sa=E&q=https%3A%2F%2Fvertexaisearch.cloud.google.com%2Fgrounding-api-redirect%2FAUZIYQEZcEcb__rKTpIq2CF68EZodJnLl6RB3ZFZg-mh5GskzmzOn20cRaM8VLSWf94YGFzNY3P3ku12HLRPXky4VM-XBJcNk4j3bwFCZNAw-N_N_QFHjOIkX5su8U0DHHZVbZdByoAUfBrzEu9L1WuE0qlIhVkyBHMmc7sn8_aH2ZRS6Faq-2tBM3StUQ%3D%3D)]

## 🚀 功能特性

- **模块化设计**：网络（VPC）与计算（EC2）解耦，易于扩展。[[1](https://www.google.com/url?sa=E&q=https%3A%2F%2Fvertexaisearch.cloud.google.com%2Fgrounding-api-redirect%2FAUZIYQEZcEcb__rKTpIq2CF68EZodJnLl6RB3ZFZg-mh5GskzmzOn20cRaM8VLSWf94YGFzNY3P3ku12HLRPXky4VM-XBJcNk4j3bwFCZNAw-N_N_QFHjOIkX5su8U0DHHZVbZdByoAUfBrzEu9L1WuE0qlIhVkyBHMmc7sn8_aH2ZRS6Faq-2tBM3StUQ%3D%3D)]
- **自动化网络**：自动创建公网子网、互联网网关（IGW）和路由表。[[1](https://www.google.com/url?sa=E&q=https%3A%2F%2Fvertexaisearch.cloud.google.com%2Fgrounding-api-redirect%2FAUZIYQEZcEcb__rKTpIq2CF68EZodJnLl6RB3ZFZg-mh5GskzmzOn20cRaM8VLSWf94YGFzNY3P3ku12HLRPXky4VM-XBJcNk4j3bwFCZNAw-N_N_QFHjOIkX5su8U0DHHZVbZdByoAUfBrzEu9L1WuE0qlIhVkyBHMmc7sn8_aH2ZRS6Faq-2tBM3StUQ%3D%3D)]
- **安全性**：预配置安全组，仅开放必要的 SSH (22) 端口。[[1](https://www.google.com/url?sa=E&q=https%3A%2F%2Fvertexaisearch.cloud.google.com%2Fgrounding-api-redirect%2FAUZIYQEZcEcb__rKTpIq2CF68EZodJnLl6RB3ZFZg-mh5GskzmzOn20cRaM8VLSWf94YGFzNY3P3ku12HLRPXky4VM-XBJcNk4j3bwFCZNAw-N_N_QFHjOIkX5su8U0DHHZVbZdByoAUfBrzEu9L1WuE0qlIhVkyBHMmc7sn8_aH2ZRS6Faq-2tBM3StUQ%3D%3D)]
- **最佳实践**：遵循 Terraform 标准目录结构，支持资源自动打标签。[[1](https://www.google.com/url?sa=E&q=https%3A%2F%2Fvertexaisearch.cloud.google.com%2Fgrounding-api-redirect%2FAUZIYQEZcEcb__rKTpIq2CF68EZodJnLl6RB3ZFZg-mh5GskzmzOn20cRaM8VLSWf94YGFzNY3P3ku12HLRPXky4VM-XBJcNk4j3bwFCZNAw-N_N_QFHjOIkX5su8U0DHHZVbZdByoAUfBrzEu9L1WuE0qlIhVkyBHMmc7sn8_aH2ZRS6Faq-2tBM3StUQ%3D%3D)][[2](https://www.google.com/url?sa=E&q=https%3A%2F%2Fvertexaisearch.cloud.google.com%2Fgrounding-api-redirect%2FAUZIYQGxNF4j1iB50EFBlQx3ASwNdZi2V0dlEZ5KB07QICJ6E-EdWa0ApxmKymWxlL26azkmJbILzEoh-NLjFXTHREtgbvtYH42_wFWLAvC6l5nT7-7EuOKBE2wFzZKywlh1HA5DytXtRHTuqubLhkfowhhUoXefiKlaMigXFrCV5VUkjAp_TBbJuSZDuCqgMqM8V63PBLJwh97j7J_yIJoHq7c%3D)]

## 🏗️ 架构概览

1. **VPC**: 10.0.0.0/16
2. **Public Subnet**: 10.0.1.0/24
3. **EC2 Instance**: Amazon Linux 2
4. **Security Group**: 允许 SSH 访问

## 🛠️ 快速开始

### 前置条件

- 已安装 [Terraform](https://www.terraform.io/downloads.html) (>= 1.5.0)
- 已配置 [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) 并拥有相应权限
- 一个 AWS 账号

### 部署步骤

1. **克隆仓库**
   ```bash
   git clone https://github.com/super-copilot/terraform-aws-project.git
   cd terraform-aws-project
   ```

2. **配置变量**
   复制示例变量文件并根据需要修改：
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **初始化与部署**
   ```bash
   terraform init    # 下载 Provider 和初始化模块
   terraform plan    # 查看预览
   terraform apply   # 执行部署 (输入 yes 确认)
   ```

## 📊 输入变量 (Inputs)

| 名称          | 描述            | 类型   | 默认值      |
| :------------ | :-------------- | :----- | :---------- |
| aws_region    | 部署的 AWS 区域 | string | `us-east-1` |
| project_name  | 项目前缀名称    | string | `app-1`     |
| instance_type | EC2 实例规格    | string | `t2.micro`  |

## 📤 输出参数 (Outputs)

| 名称          | 描述                     |
| :------------ | :----------------------- |
| ec2_public_ip | 部署好的 EC2 实例公网 IP |

## ⚠️ 注意事项

- **成本**：此模板使用的 `t2.micro` 在 AWS 免费套餐内，但请务必在测试完成后运行 `terraform destroy` 以避免产生意外费用。
- **安全**：默认安全组允许 `0.0.0.0/0` 的 SSH 访问，建议在生产环境中将其修改为特定的 IP。

