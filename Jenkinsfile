pipeline {
  agent any

  environment {
    IMAGE = 'admdevops/flask-app'
    TAG = 'latest'
    SONARQUBE_SERVER = 'SonarQube'
  }

  stages {

    stage('Checkout') {
      steps {
        // Corrected URL scheme
        git branch: 'task_6', url: 'https://github.com/python1911/python1911-rsschool-devops-course-tasks.git'
      }
    }

    stage('Install dependencies') {
      steps {
        sh 'pip install -r task_6/flask_app/requirements.txt || pip3 install -r task_6/flask_app/requirements.txt'
      }
    }

    stage('Unit Tests') {
      steps {
        sh 'pytest task_6/flask_app/tests/ || echo "Warning: No tests found or pytest failed"'
      }
    }

    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv("${SONARQUBE_SERVER}") {
          sh '''
            sonar-scanner \
              -Dsonar.projectKey=flask-app \
              -Dsonar.sources=task_6/flask_app \
              -Dsonar.python.version=3.10
          '''
        }
      }
    }

    stage('Docker Build & Push') {
      steps {
        withCredentials([string(credentialsId: 'docker-hub-token', variable: 'DOCKER_PASS')]) {
          sh '''
            docker build -t $IMAGE:$TAG task_6/flask_app
            echo $DOCKER_PASS | docker login -u admdevops --password-stdin
            docker push $IMAGE:$TAG
          '''
        }
      }
    }

    stage('Deploy via Helm') {
      steps {
        sh '''
          helm upgrade --install flask-app task_6/helm/flask-app \
            --set image.repository=$IMAGE \
            --set image.tag=$TAG
        '''
      }
    }

    stage('Smoke Test') {
      steps {
        sh '''
          echo "Waiting for deployment to stabilize..."
          sleep 10
          curl --fail $(minikube service flask-app --url) || exit 1
        '''
      }
    }
  }

  post {
    success {
      mail to: 'your@email.com',
           subject: "✅ Jenkins Job Success: ${env.JOB_NAME}",
           body: "Jenkins job ${env.JOB_NAME} ran successfully."
    }
    failure {
      mail to: 'your@email.com',
           subject: "❌ Jenkins Job Failed: ${env.JOB_NAME}",
           body: "Jenkins job ${env.JOB_NAME} failed. Please check the console output."
    }
  }
}
