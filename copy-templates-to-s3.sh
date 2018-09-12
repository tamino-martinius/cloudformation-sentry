#!/usr/bin/env bash

cd $(dirname $0)
set -x

source ./env

CACHE="max-age=31536000,public"
NO_CACHE="max-age=0,no-cache,no-store,must-revalidate"

aws s3 sync output s3://$AWS_BUCKET_NAME --cache-control $CACHE --acl public-read --region $AWS_REGION
aws s3 cp output s3://$AWS_BUCKET_NAME --exclude "*" --include "master-*.yaml" --cache-control $NO_CACHE --recursive --acl public-read --region $AWS_REGION
