# 🧠 Wisdom Quotes API

A fun, lightweight Flask-based API that delivers random wisdom quotes to inspire and enlighten you!

---

## 🚀 Project Vision

We start small—with **Version 0**—featuring just 8 curated wisdom quotes in English. But this is only the beginning.

Our roadmap includes:
- 📈 **Quote Expansion**: Add hundreds of quotes from diverse cultures and thinkers.
- 🌐 **Multilingual Support**: Serve quotes in multiple languages (Arabic, Urdu, French, etc.).
- 📚 **Categorization**: Wisdom by theme (Life, Knowledge, Love, Success, etc.).
- 🧠 **AI-Powered Tagging**: Use NLP to classify and personalize quotes.

---

## 🛠️ Tech Stack

| Component       | Technology             |
|----------------|------------------------|
| Backend         | Python (Flask)         |
| Containerization| Docker                 |
| Hosting         | Amazon ECS (Fargate)   |
| Registry        | Amazon ECR             |
| CI/CD           | AWS CodePipeline       |
| Source Control  | GitHub / CodeCommit    |

---

## 📦 Current Features (v0)

- `GET /` — Simple welcome page
- `GET /quote` — Returns a random quote from a hardcoded list of 8 timeless quotes

**Example Response:**

```json
{
  "quote": "The only true wisdom is in knowing you know nothing. – Socrates"
}

🐳 Local Development
git clone https://github.com/your-username/wisdom-quotes-api.git
cd wisdom-quotes-api
docker build -t wisdom-api .
docker run -p 8080:8080 wisdom-api

☁️ Cloud Deployment (ECS + Fargate)
This app is containerized using Docker and deployed to AWS ECS with Fargate. CI/CD is automated using CodePipeline with CodeBuild + GitHub trigger.

# ✅ Wisdom Quotes API Deployment Checklist

A step-by-step guide to build, containerize, and deploy the Wisdom Quotes API on AWS using ECS (Fargate), ECR, and CodePipeline.  
We start manually through the AWS Console, then move toward automation.

---

## ✅ PHASE 1: Local Setup & Testing

- [x] Create project folder with:
  - `app.py` (Flask app with 8 wisdom quotes)
  - `requirements.txt`
  - `Dockerfile`
  - `buildspec.yml`
  - `README.md`
- [x] Initialize Git & push to GitHub
- [x] Test Flask app locally via:
  ```bash
  pip install -r requirements.txt
  python app.py

 Build and run Docker container locally:
docker build -t wisdom-api .
docker run -p 8080:8080 wisdom-api

☁️ PHASE 2: AWS Manual Setup
🔹 Step 1: Amazon ECR
 Create ECR repo wisdom-quotes-api

 Authenticate Docker with ECR:
aws ecr get-login-password | docker login --username AWS --password-stdin <account>.dkr.ecr.<region>.amazonaws.com

 Tag and push Docker image to ECR:

docker tag wisdom-api:latest <account>.dkr.ecr.<region>.amazonaws.com/wisdom-quotes-api:latest
docker push <account>.dkr.ecr.<region>.amazonaws.com/wisdom-quotes-api:latest

🔹 Step 2: Amazon ECS (Fargate)
 Create ECS Cluster (Networking only - Fargate)

 Create Task Definition with:

Container name: wisdom-container

Image URI: from ECR

Port: 8080

 Create ECS Service:

Attach VPC + subnet

Assign public IP

 Verify ECS service public URL is reachable

🔹 Step 3: CodeBuild (GUI)
 Create CodeBuild project wisdom-quotes-build

 Connect GitHub as source

 Use buildspec.yml from repo

 Enable “privileged mode” (for Docker)

 Ensure IAM Role has permissions:

Push to ECR

Write logs to CloudWatch

Update ECS service (optional for pipeline)

🔹 Step 4: CodePipeline (GUI)
 Create pipeline wisdom-quotes-pipeline

 Set GitHub as source

 Add CodeBuild project as build stage

 Add ECS Deploy stage with:

Cluster + service

imagedefinitions.json artifact from CodeBuild

🚀 PHASE 3: Deployment Test & Validation
 Make a change (e.g., new quote in app.py)

 Commit + push to GitHub

 Watch CodePipeline trigger and complete all stages

 Visit ECS URL /quote to verify new quote is live



