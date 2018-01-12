#! /bin/bash

# Log in to ECR
echo "Logging in to ECR"
eval $(aws ecr get-login --no-include-email --region us-east-1)

# Set up build variables
echo "Setting build variables"
ecr_repo=$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/bart_scrape

# Build the container and tag it with the sha
echo "Building the container"
aws s3 cp s3://bart-scrape/prod.secret.exs config/prod.secret.exs
docker build -t latest .

# Push the container to ECR
echo "Pushing the container"
docker push $ecr_repo:latest

# Set the compose tasks
ecs-cli compose --file deploy/ecs-compose.yml \
                --project-name bart-scrape \
                --cluster bart-scrape \
                up
