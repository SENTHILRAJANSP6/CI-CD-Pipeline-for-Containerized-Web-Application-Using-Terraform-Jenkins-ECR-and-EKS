pipeline {
  agent any
  environment {
    IMAGE = "<your_ecr_repo_url>:${env.BUILD_NUMBER}"
  }
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/SENTHILRAJANSP6/CI-CD-Pipeline-for-Containerized-Web-Application-Using-Terraform-Jenkins-ECR-and-EKS.git'
      }
    }
    stage('Code Quality - SonarQube') {
      steps {
        withSonarQubeEnv('MySonarQubeServer') {
          sh 'sonar-scanner -Dsonar.projectKey=devops-app -Dsonar.sources=./app -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_AUTH_TOKEN'
        }
      }
    }
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE .'
      }
    }
    stage('Push to ECR') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
          sh '''
            aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <your_account_id>.dkr.ecr.ap-south-1.amazonaws.com
            docker push $IMAGE
          '''
        }
      }
    }
    stage('Deploy to EKS') {
      steps {
        sh 'helm upgrade --install myapp ./k8s/helm --set image.tag=$BUILD_NUMBER'
      }
    }
  }
}
