#!/bin/bash

echo "Creating ecsTaskExecutionRole..."
aws iam create-role --role-name ecsTaskExecutionRole \
  --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": { "Service": "ecs-tasks.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }]
  }' || echo "ecsTaskExecutionRole already exists"

aws iam attach-role-policy --role-name ecsTaskExecutionRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy

echo "Creating codebuild-ecs-service-role..."
aws iam create-role --role-name codebuild-ecs-service-role \
  --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": { "Service": "codebuild.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }]
  }' || echo "codebuild-ecs-service-role already exists"

aws iam attach-role-policy --role-name codebuild-ecs-service-role \
  --policy-arn arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess

aws iam put-role-policy --role-name codebuild-ecs-service-role \
  --policy-name inline-ecr-access \
  --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:*",
          "s3:*"
        ],
        "Resource": "*"
      }
    ]
  }'

echo "Creating AWSCodePipelineServiceRole..."
aws iam create-role --role-name AWSCodePipelineServiceRole \
  --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": { "Service": "codepipeline.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }]
  }' || echo "AWSCodePipelineServiceRole already exists"

aws iam attach-role-policy --role-name AWSCodePipelineServiceRole \
  --policy-arn arn:aws:iam::aws:policy/AWSCodePipelineFullAccess

