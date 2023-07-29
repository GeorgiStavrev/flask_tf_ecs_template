#!/bin/bash
USER_NAME={{ cookiecutter.project_slug }}-tf-deployment-user
aws iam create-user --user-name $USER_NAME
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --user-name $USER_NAME
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess --user-name $USER_NAME
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --user-name $USER_NAME
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess --user-name $USER_NAME
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess  --user-name $USER_NAME
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/service-role/AmazonSNSRole  --user-name $USER_NAME
aws iam attach-user-policy --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/TerraformDeployment --user-name $USER_NAME
aws iam create-access-key --user-name $USER_NAME