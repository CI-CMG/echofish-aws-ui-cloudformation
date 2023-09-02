#!/bin/bash
set -ex

version=$(jq -r '.version' target/dev-resources/stack-properties.json)
bucket_name=$(jq -r '.[] | select(.ParameterKey == "DeploymentBucketName").ParameterValue' target/dev-resources/deployment-parameters.json)

rm -rf target/echofish-aws-ui-cloudformation-$version

unzip -d target target/echofish-aws-ui-cloudformation-$version.zip

aws --profile echofish s3 sync target/echofish-aws-ui-cloudformation-$version s3://$bucket_name/