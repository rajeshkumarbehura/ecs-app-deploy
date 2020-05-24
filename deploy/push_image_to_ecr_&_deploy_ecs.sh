echo "*************************************************************************"
echo "TO DEPLOY THE CODE, YOU NEED TO HAVE AWS CLI & TERRAFORM CLI INSTALLED."
echo "*************************************************************************"
cd ..

#it can be any version, depends on user choice either hardcoded version or from war/jar file or packaage.json
PACKAGE_VERSION=$(node -p -e "require('./demo-app/package.json').version")
#PACKAGE_VERSION=1.0.0

#Update parameters before running
# AWS configuration details
AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXX
AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXX
AWS_REGION=XXXXXXXXXXXXXXX
AWS_PROFILE=dev
#Custom ECR REPO Name. any name for repo
ECR_REPO_NAME=demo_app_repo
#Application Name
APP_NAME=demo-app
# first create ECR repo with create_repo_in_ecr sh file and give the path here
ECR_REPO_PATH=XXXXXXXXXXXXXXX.dkr.ecr.ap-southeast-1.amazonaws.com/demo_app_repo
#Application Folder location
APP_LOCATION=./demo-app/

cd $APP_LOCATION

# go to inside application folder
#docker build -t dev-webcore:"$PACKAGE_VERSION"  .
docker build -t "$APP_NAME":"$PACKAGE_VERSION" .

# aws configure set varname value [--profile profile-name]
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"  --profile "$AWS_PROFILE"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$AWS_PROFILE"
aws configure set region "$AWS_REGION" --profile "$AWS_PROFILE"
aws configure set output json --profile "$AWS_PROFILE"


# create repository
aws ecr create-repository --repository-name  "$ECR_REPO_NAME"


echo "docker image created with package version :$PACKAGE_VERSION"

# tag doker image for ecr image
echo "$APP_NAME:$PACKAGE_VERSION" "$ECR_REPO_PATH:$PACKAGE_VERSION"
docker tag "$APP_NAME:$PACKAGE_VERSION" "$ECR_REPO_PATH:$PACKAGE_VERSION"

$(aws ecr get-login --no-include-email --no-include-email | sed 's|https://||')

#push tagged image to ecr
docker push "$ECR_REPO_PATH:$PACKAGE_VERSION"



# Deploy code thru terraform
cd ..

cd deploy/terraform

# envirnoment variable demoapp_image for terraform
#export TF_VAR_webcore_image="XXXXX.dkr.ecr.ap-southeast-1.amazonaws.com/demo-app:$PACKAGE_VERSION"
export TF_VAR_demoapp_image="$ECR_REPO_PATH:$PACKAGE_VERSION"

terraform init

terraform plan

terraform apply -auto-approve
