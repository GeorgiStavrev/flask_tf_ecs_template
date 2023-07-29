fmt:
	terraform fmt -recursive

init:
	terraform init -reconfigure -backend-config=./tfenv/prod/prod.s3.tfbackend
plan: init
	terraform plan -var-file="./tfenv/prod/prod.tfvars"
apply: init
	terraform apply -var-file="./tfenv/prod/prod.tfvars" ${APPLY_ARGS}
destroy: init
	terraform destroy -var-file="./tfenv/prod/prod.tfvars"

init-test:
	terraform init -reconfigure -backend-config=./tfenv/test/test.s3.tfbackend
plan-test: init-test
	terraform plan -var-file="./tfenv/test/test.tfvars" 
apply-test: init-test
	terraform apply -var-file="./tfenv/test/test.tfvars" ${APPLY_ARGS}
destroy-test: init-test
	terraform destroy -var-file="./tfenv/test/test.tfvars"
