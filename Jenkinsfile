pipeline {
  agent any

  environment {
    IMAGE_NAME = "mon-site:${env.BUILD_NUMBER}"
    CONTAINER_NAME = "mon-site"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Test') {
      steps {
        sh 'chmod +x tests/run_tests.sh || true'
        // If tests exist
        sh 'if [ -f tests/run_tests.sh ]; then ./tests/run_tests.sh; else echo "No tests script, running basic checks"; grep -q "<html" index.html; fi'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${IMAGE_NAME} ."
      }
    }

    stage('Deploy') {
      steps {
        // Stop existing container (if exists) and run new one
        sh """
          if docker ps -q -f name=${CONTAINER_NAME}; then
            docker rm -f ${CONTAINER_NAME}
          fi
          docker run -d --name ${CONTAINER_NAME} -p 80:80 ${IMAGE_NAME}
        """
      }
    }
  }

  post {
    success {
      echo "Pipeline succeeded. Site deployed."
    }
    failure {
      echo "Pipeline failed."
    }
  }
}
