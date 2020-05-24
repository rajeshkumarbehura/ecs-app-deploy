AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXX
AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXX
AWS_REGION=XXXXXXXXXXXXXXX
AWS_PROFILE=dev
ECR_REPO_NAME=demo_app_repo


# aws configure set varname value [--profile profile-name]
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"  --profile "$AWS_PROFILE"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$AWS_PROFILE"
aws configure set region "$AWS_REGION" --profile "$AWS_PROFILE"
aws configure set output json --profile "$AWS_PROFILE"


# create repository
aws ecr create-repository --repository-name  "$ECR_REPO_NAME"

# after created repo, it will print the repo path in console.
