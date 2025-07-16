#!/bin/bash

# AWS Configuration
REGION="us-east-1"
PATTERN="wisdom"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

echo "🔍 Cleaning up ALL resources matching name pattern: $PATTERN"

# Optional: export AWS_PROFILE=admin

#########################################
# ECS Cleanup
#########################################
echo "🧹 Cleaning ECS..."

CLUSTERS=$(aws ecs list-clusters --region $REGION --query 'clusterArns' --output text)
for CLUSTER in $CLUSTERS; do
  if [[ "$CLUSTER" == *"$PATTERN"* ]]; then
    SERVICES=$(aws ecs list-services --cluster "$CLUSTER" --region $REGION --query 'serviceArns' --output text)
    for SERVICE in $SERVICES; do
      echo "🧨 Deleting service: $SERVICE"
      aws ecs update-service --cluster "$CLUSTER" --service "$SERVICE" --desired-count 0 --region $REGION
      sleep 5
      aws ecs delete-service --cluster "$CLUSTER" --service "$SERVICE" --force --region $REGION
    done

    echo "🧨 Deleting cluster: $CLUSTER"
    aws ecs delete-cluster --cluster "$CLUSTER" --region $REGION
  fi
done

#########################################
# ECR Repositories
#########################################
echo "🧹 Cleaning ECR repos..."
REPOS=$(aws ecr describe-repositories --region $REGION --query 'repositories[*].repositoryName' --output text)
for REPO in $REPOS; do
  if [[ "$REPO" == *"$PATTERN"* ]]; then
    echo "🧨 Deleting ECR repo: $REPO"
    aws ecr delete-repository --repository-name "$REPO" --force --region $REGION
  fi
done

#########################################
# CodeBuild Projects
#########################################
echo "🧹 Cleaning CodeBuild..."
PROJECTS=$(aws codebuild list-projects --region $REGION --output text)
for PROJECT in $PROJECTS; do
  if [[ "$PROJECT" == *"$PATTERN"* ]]; then
    echo "🧨 Deleting CodeBuild project: $PROJECT"
    aws codebuild delete-project --name "$PROJECT" --region $REGION
  fi
done

#########################################
# CodePipeline Pipelines
#########################################
echo "🧹 Cleaning CodePipeline..."
PIPELINES=$(aws codepipeline list-pipelines --region $REGION --query 'pipelines[*].name' --output text)
for PIPELINE in $PIPELINES; do
  if [[ "$PIPELINE" == *"$PATTERN"* ]]; then
    echo "🧨 Deleting CodePipeline: $PIPELINE"
    aws codepipeline delete-pipeline --name "$PIPELINE" --region $REGION
  fi
done

#########################################
# ENI Cleanup (Detached only)
#########################################
echo "🧹 Cleaning detached ENIs matching $PATTERN..."

ENIS=$(aws ec2 describe-network-interfaces --region $REGION \
  --query 'NetworkInterfaces[?Status==`available`].[NetworkInterfaceId,Description]' \
  --output text)

while IFS=$'\t' read -r ENI_ID DESCRIPTION; do
  if [[ "$DESCRIPTION" == *"$PATTERN"* ]]; then
    echo "🧨 Deleting ENI: $ENI_ID  ($DESCRIPTION)"
    aws ec2 delete-network-interface --network-interface-id "$ENI_ID" --region $REGION
  fi
done <<< "$ENIS"

echo "✅ Cleanup complete. All $PATTERN-related resources have been purged."

