pipeline {
    agent any
    environment {
        DOCKER_HUB_USER = 'umair81'
        IMAGE_NAME = 'my-flask-app'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url 'https://github.com/Umair-Devops-425/CI-CD_Pipeline_with_Jenkins_Docker_and_Kubernetes.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_HUB_USER/$IMAGE_NAME:latest .'
            }
        }
        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $DOCKER_HUB_USER/$IMAGE_NAME:latest'
                }
            }
        }
    }
}
