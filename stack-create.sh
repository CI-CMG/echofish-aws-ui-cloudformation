#!/bin/bash
set -ex

./deploy-sync.sh

stack_name=$(jq -r '.stackName' target/dev-resources/stack-properties.json)
bucket_name=$(jq -r '.[] | select(.ParameterKey == "DeploymentBucketName").ParameterValue' target/dev-resources/deployment-parameters.json)

aws cloudformation create-stack \
  --profile echofish \
  --disable-rollback \
  --stack-name $stack_name \
  --template-url https://s3.amazonaws.com/$bucket_name/stack/echofish-stack.yaml \
  --capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND \
  --parameters file://target/dev-resources/echofish-parameters.json