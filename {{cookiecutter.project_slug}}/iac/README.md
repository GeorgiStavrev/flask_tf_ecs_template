# TODO

Convert the scripts to terraform that is run only once (no remote state needed).

# Prerequisites

1. Set environment variables:

```bash
export AWS_ACCOUNT_ID=???
export AWS_DEFAULT_REGION=???
```

2. IAM Policies - `create_policies.sh`
3. IAM deployment user - `create_iam_iac_deployment_user.sh`
4. S3 bucket for terraform state - `create_state_s3_bucket.sh`
5. DynamoDb table for terraform state lock - `create_dynamodb_table.sh`

# Resources created in AWS:

- VPC along with subnets, security groups
- ECR repo
- ECS cluster
- ECS task definition
- ECS service using FARGATE SPOT
- ALB (Application load balancer) along with listeners, ENI
- Secrets in secret manager - used by the ECS task definition
- CloudWatch Dashboard for service operational metrics

# Lifecycle

- On PR creation the IaC stack is applied to the production account and creates resources for `test` (names suffixed by `-test`)
- On PR merge - nothing happens currentlt, but there's a github workflow that can be triggered manually to deploy `prod` resources (suffixed by `-prod`)
