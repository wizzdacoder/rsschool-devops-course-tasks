# Task 6: Application Deployment via Jenkins Pipeline

## ✅ Task Description

Implement a CI/CD pipeline using Jenkins that performs the following:
- Clones the repository from GitHub
- Installs Python dependencies
- Runs unit tests
- Performs SonarQube analysis
- Builds and pushes a Docker image to Docker Hub
- Deploys the app to Kubernetes using Helm
- Verifies the deployment via a smoke test

---

## 📁 Project Structure

```

task\_6/
├── Jenkinsfile
├── flask\_app/
│   ├── app.py
│   ├── requirements.txt
│   └── tests/
│       └── test\_app.py
└── helm/
└── flask-app/
├── Chart.yaml
├── values.yaml
└── templates/
├── deployment.yaml
└── service.yaml

````

---

## ⚙️ Jenkins Pipeline Stages

1. **Checkout** — Pulls the latest code from `task_6` branch.
2. **Install dependencies** — Uses `pip` to install Python requirements.
3. **Unit Tests** — Runs `pytest` to verify functionality.
4. **SonarQube Analysis** — Scans code using `sonar-scanner`.
5. **Docker Build & Push** — Builds the Docker image and pushes to Docker Hub:
   - Repository: `admdevops/flask-app`
   - Tag: `latest`
6. **Deploy via Helm** — Deploys the Flask app using Helm chart.
7. **Smoke Test** — Verifies that the app is running correctly using `curl`.

---

## 🐳 Docker

To build locally:

```bash
docker build -t flask-app:test ./task_6/flask_app
````

To push to Docker Hub:

```bash
docker tag flask-app:test admdevops/flask-app:latest
docker push admdevops/flask-app:latest
```

---

## ⎈ Helm Deployment

```bash
helm upgrade --install flask-app ./task_6/helm/flask-app \
  --set image.repository=admdevops/flask-app \
  --set image.tag=latest
```

---

## 🔍 Smoke Test

```bash
minikube service flask-app --url
curl http://<minikube-service-url>
```

Expected output:

```
Hello from Flask!
```

---

## ✅ Done

All pipeline stages are implemented and verified.
Docker image is published to: [https://hub.docker.com/r/admdevops/flask-app](https://hub.docker.com/r/admdevops/flask-app)

--
