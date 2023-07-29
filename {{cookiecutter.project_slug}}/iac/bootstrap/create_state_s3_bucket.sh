#!/bin/bash
BUCKET_NAME={{ cookiecutter.project_slug }}-tf
USER_NAME={{ cookiecutter.project_slug }}-tf-deployment-user

aws s3api create-bucket --bucket $BUCKET_NAME --region $AWS_DEFAULT_REGION --create-bucket-configuration LocationConstraint=$AWS_DEFAULT_REGION
aws s3api put-bucket-encryption --bucket $BUCKET_NAME --server-side-encryption-configuration "{\"Rules\":[{\"ApplyServerSideEncryptionByDefault\":{\"SSEAlgorithm\":\"AES256\"}}]}"
sed -i '' "s/<AccountID>/$AWS_ACCOUNT_ID/g" bucket_policy.json
sed -i '' "s/<UserName>/$USER_NAME/g" bucket_policy.json
sed -i '' "s/<BucketName>/$BUCKET_NAME/g" bucket_policy.json
aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy file://bucket_policy.json
sed -i '' "s/$AWS_ACCOUNT_ID/<AccountID>/g" bucket_policy.json
sed -i '' "s/$USER_NAME/<UserName>/g" bucket_policy.json
sed -i '' "s/$BUCKET_NAME/<BucketName>/g" bucket_policy.json
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled
aws s3api put-public-access-block --bucket $BUCKET_NAME --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"