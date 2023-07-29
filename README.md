# Opinionated cookiecutter template for a Python Flask web service

- written in Python Flask
- with Github workflows and PR template
- with infrastructure as code with Terraform
- to be deployed on AWS ECS

## Components

- Flask service (`src/`)
  - Service 2 service authentication supported with custom header/token
  - Local and remote configuration (with AWS Parameter Store)
  - Uses flask-smorest
  - !See Makefile for linting, running tests/app
- IaC (`iac/`)

  - `iac/bootstrap`: Bootstrapping code in bash to create necessary user and policies for Terraform

    - See `README.md` inside
    - NB!`export AWS_ACCOUNT_ID=<your account id here>` before running the scripts.
    - S3 Backend for terraform (S3 bucket and Dynamodb table also created via bootstrap bash scripts)

  - ECR repository for storing application images
  - ECS service running on Fargate
  - CloudWatch log groups
  - CloudWatch alarms
  - CloudWatch dashboard - basic
  - Prerequisites
    - It relies on some shared infrastructure you should prepare - shared ECS cluster, ALB
    - !See Makefile for applying IaC on test or prod environments

- Monitoring
  - CW logs, alarms, dashboard created by aws
  - Alarms can be send to Slack (set `slack_webhook_alarms` terraform variable)

## Usage

- This template is quite opionated, so although it allows you to spin-up a service and deploy in minutes you may want to change some things more to your liking

- Generate your service with this cookiecutter

```bash
cookiecutter gh:GeorgiStavrev/flask_tf_ecs_template
```

- Automated checks and deployment via Github Actions
  `Add the following secrets to your github.com repository, so that the github actions could work:`
  - AWS_ACCOUNT_ID - the one of you aws account
  - AWS_ACCESS_KEY_ID - get from the output of `iac/bootstrap/create_iam_iac_deployment_user.sh`
  - AWS_SECRET_ACCESS_KEY - get from the output of `iac/bootstrap/create_iam_iac_deployment_user.sh`
  - AWS_DEFAULT_REGION - defaults to `eu-west-1` (also change `availability_zones` terraform variable if you change the region)
  - JWT_SECRET - set your own value
  - SLACK_ALARMS_WEBHOOK_URL - either set this if you want to send CloudWatch alarms to slack or remove it and code depending on it
