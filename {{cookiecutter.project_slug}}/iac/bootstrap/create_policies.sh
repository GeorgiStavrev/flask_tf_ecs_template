#!/bin/bash
aws iam create-policy --policy-name Terraform{{ cookiecutter.project_slug }}Deployment --policy-document file://terraform_deployment_policy.json