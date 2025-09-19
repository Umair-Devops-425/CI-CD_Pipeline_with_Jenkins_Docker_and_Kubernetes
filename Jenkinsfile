pipeline {
    agent any
    
    environment {
        DOCKER_HUB_USER = 'umair81'
        IMAGE_NAME = 'my-flask-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Umair-Devops-425/CI-CD_Pipeline_with_Jenkins_Docker_and_Kubernetes.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} ."
                    sh "docker tag ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    script {
                        echo "Logging into DockerHub as ${USER}"
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                        echo "Pushing images to DockerHub"
                        sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }
        
        stage('Clean Up') {
            steps {
                script {
                    echo "Cleaning up local Docker images"
                    sh "docker rmi ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} || true"
                    sh "docker rmi ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest || true"
                }
            }
        }
    }
    
    post {
        always {
            script {
                sh 'docker logout'
            }
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for details.'
        }
    }
}