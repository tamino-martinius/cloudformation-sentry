#!/bin/bash

cd $(dirname $0)
set -x

source ./env

aws cloudformation describe-stacks --stack-name "$STACK_NAME"&>/dev/null
if [ $? -eq 0 ]
then
  echo "Updating existing stack"
  aws cloudformation update-stack --stack-name "$STACK_NAME" --template-body "./output/$TEMPLATE" --region "$AWS_REGION" --parameters "$OWNER" "$SENTRY_USER" "$SENTRY_PASSWORD" "$DNS_NAME" "$SSL_CERT_ARN" "$SSH_KEY_NAME" "$DB_USERNAME" "$DB_PASSWORD" "$SENTRY_SECRET_KEY" "$GITHUB_APP_ID" "$GITHUB_API_SECRET" "$MAIL_USERNAME" "$MAIL_PASSWORD" "$MAIL_FROM" --capabilities CAPABILITY_IAM
else
  echo "Creating new stack"
  aws cloudformation create-stack --stack-name "$STACK_NAME" --template-body "./output/$TEMPLATE" --region "$AWS_REGION" --parameters "$OWNER" "$SENTRY_USER" "$SENTRY_PASSWORD" "$DNS_NAME" "$SSL_CERT_ARN" "$SSH_KEY_NAME" "$DB_USERNAME" "$DB_PASSWORD" "$SENTRY_SECRET_KEY" "$GITHUB_APP_ID" "$GITHUB_API_SECRET" "$MAIL_USERNAME" "$MAIL_PASSWORD" "$MAIL_FROM" --capabilities CAPABILITY_IAM
fi
