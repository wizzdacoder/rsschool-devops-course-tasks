# 🐍 Flask App Deployment with Helm (Task 5)

This README documents the setup and deployment of a simple Flask application on a Kubernetes (Minikube) cluster using Helm. This task was completed as part of the DevOps course.

---

## ✅ Objective

- Create a Docker image for a Flask application.
- Write a Helm chart to deploy the application.
- Ensure the application is accessible via a web browser.
- Document the setup and deployment process.

---

## 📁 Project Structure

```
task_5/
├── flask-app/                 # Flask application and Dockerfile
│   ├── app.py
│   ├── Dockerfile
│   └── templates/
│       └── index.html
│
└── flask-app-chart/          # Helm chart
    ├── Chart.yaml
    ├── values.yaml
    └── templates/
        ├── deployment.yaml
        └── service.yaml
```

---

## 🚀 Steps to Deploy

### 1. 🐳 Build and Push Docker Image

```bash
cd flask-app/
docker build -t <your-dockerhub-username>/flask-app:v1 .
docker push <your-dockerhub-username>/flask-app:v1
```

Update the `values.yaml` in your Helm chart to match the image name and tag.

---

### 2. 🧪 Start Minikube and Set Docker Context (if needed)

```bash
minikube start --driver=docker
```

Optional (to build Docker image directly in Minikube):

```bash
eval $(minikube docker-env)
```

---

### 3. 🧭 Deploy Helm Chart

```bash
helm install flask-app ./flask-app-chart -n flask --create-namespace
```

---

### 4. 🌐 Access the Application

```bash
minikube service flask-app-flask-app-chart -n flask --url
```

Open the provided URL in your browser. You should see the Flask homepage rendered from `index.html`.

---

### 5. 🔍 Troubleshooting

To view logs:

```bash
kubectl logs -n flask <your-pod-name>
```

To describe pod and check events:

```bash
kubectl describe pod -n flask <your-pod-name>
```

---

## 📸 Screenshots Required

- ✅ Application running in the browser
- ✅ `kubectl get all -n flask` output
- ✅ Screenshot of `task_5` branch with code and chart committed

---

## 📝 Notes

- The Flask app is a basic "Hello from Flask" webpage using Jinja2 templates.
- The Helm chart creates a `Deployment` and a `NodePort` service.
- The image is built from a custom `Dockerfile` that installs Flask and serves the app on port 5000.
- The `index.html` must be inside a `templates/` directory for Flask to render it.

---

## 🧠 Learned Concepts

- Dockerfile creation for Python apps
- Building and pushing images to Docker Hub
- Helm chart structure and usage
- Deploying services on Minikube with Helm
- Using Kubernetes to expose and manage containerized apps

---

## 🧑 Author

Alan Demian Beltramo  
DevOps Course – Task 5  
July 2025
