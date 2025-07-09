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
