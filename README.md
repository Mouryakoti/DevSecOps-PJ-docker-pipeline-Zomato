# DevSecOps Project – Dockerized React App with Jenkins, SonarQube & Trivy

This repository contains a **React frontend application** that has been Dockerized and integrated into a **CI/CD pipeline** using **Jenkins**, **SonarQube**, and **Trivy**.
The project demonstrates **DevSecOps practices** by combining continuous integration, automated code quality analysis, container image scanning, and deployment into a single automated pipeline.

---

## 🏗️ Tech Stack

* **Frontend:** React.js
* **CI/CD Tool:** Jenkins (Declarative Pipeline)
* **Code Quality:** SonarQube
* **Security Scanning:** Trivy
* **Containerization:** Docker
* **Registry:** Docker Hub

---

## 📂 Repository Structure

```
.
├── Dockerfile        # Docker instructions to containerize the React app
├── Jenkinsfile       # Jenkins declarative pipeline for CI/CD
├── public/           # React public assets
├── src/              # React source code
└── package.json      # React dependencies & scripts
```

---

## 🚀 Jenkins Pipeline Workflow

The CI/CD pipeline is defined in the `Jenkinsfile`. Below are the pipeline stages:

### 1️⃣ **Clean Workspace**

```groovy
cleanWs()
```

Ensures Jenkins workspace is clean before every run.

### 2️⃣ **Checkout Code**

```groovy
git branch: 'main', url: 'https://github.com/Mouryakoti/DevSecOps-PJ-docker-pipeline-Zomato.git'
```

Pulls the latest code from the GitHub repo.

### 3️⃣ **Code Quality Analysis (SonarQube)**

```groovy
withSonarQubeEnv('mysonar') {
   sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=zomato"
}
```

* Runs **SonarQube analysis** on the source code.
* Checks code quality, bugs, vulnerabilities, and technical debt.

### 4️⃣ **Quality Gate Check**

```groovy
waitForQualityGate abortPipeline: false, credentialsId: 'sonar-pswd'
```

* Verifies project passes **SonarQube Quality Gates** before proceeding.

### 5️⃣ **Build Docker Image**

```groovy
sh 'docker build -t image1 .'
```

* Builds a Docker image for the React app.

### 6️⃣ **Security Scan with Trivy**

```groovy
sh 'trivy image image1'
```

* Scans Docker image for **vulnerabilities** (OS & dependencies).

### 7️⃣ **Tag & Push Docker Image**

```groovy
sh 'docker tag image1 mourya09/dockpj:zomato'
withDockerRegistry(credentialsId: 'docker-hub') {
   sh 'docker push mourya09/dockpj:zomato'
}
```

* Tags the image and pushes it to **Docker Hub**.

### 8️⃣ **Deploy Container**

```groovy
sh 'docker run -itd --name zomato -p 3000:3000 mourya09/dockpj:zomato'
```

* Runs the container locally, exposing it on **port 3000**.

---

## 🔒 DevSecOps Highlights

* **Automated Code Quality Check** → via SonarQube.
* **Security First** → container scanning with Trivy before deployment.
* **Continuous Integration & Deployment** → Jenkins pipeline automates everything from checkout to deploy.

---

## ⚙️ How to Run Locally

### Prerequisites

* Docker installed
* Node.js installed (if running without Docker)
* Jenkins, SonarQube, and Trivy configured

### Run with Docker

```bash
# Build image
docker build -t zomato-app .

# Run container
docker run -it -p 3000:3000 zomato-app
```
portfolio recruiters?

