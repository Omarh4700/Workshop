pipeline {
    agent any

    environment {
        REGION             = "us-east-1"

        // Public ECR repos
        ECR_DB             = "public.ecr.aws/b0w0w8l4/vp-app-db"
        ECR_NGINX          = "public.ecr.aws/b0w0w8l4/vp-app-nginx"
        ECR_APP_TOMCAT     = "public.ecr.aws/b0w0w8l4/vp-app-tomcat"

        BRANCH             = "docker-app"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: "${BRANCH}", url: "https://github.com/Omarh4700/Workshop.git"
            }
        }

        stage('Get Git SHA') {
            steps {
                script {
                    GIT_SHA = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    echo "Image Tag Used: ${GIT_SHA}"
                }
            }
        }

        stage('Login to Public ECR') {
            steps {
                sh """
                aws ecr-public get-login-password --region ${REGION} \
                | docker login --username AWS --password-stdin public.ecr.aws/b0w0w8l4
                """
            }
        }

        stage('Build & Push DB Image') {
            steps {
                sh """
                docker build -t ${ECR_DB}:${GIT_SHA} -t ${ECR_DB}:latest ./db
                docker push ${ECR_DB}:${GIT_SHA}
                docker push ${ECR_DB}:latest
                """
            }
        }

        stage('Build & Push Nginx Image') {
            steps {
                sh """
                docker build -t ${ECR_NGINX}:${GIT_SHA} -t ${ECR_NGINX}:latest ./nginx
                docker push ${ECR_NGINX}:${GIT_SHA}
                docker push ${ECR_NGINX}:latest
                """
            }
        }

        stage('Build & Push Tomcat App Image') {
            steps {
                sh """
                docker build -t ${ECR_APP_TOMCAT}:${GIT_SHA} -t ${ECR_APP_TOMCAT}:latest ./tom-app
                docker push ${ECR_APP_TOMCAT}:${GIT_SHA}
                docker push ${ECR_APP_TOMCAT}:latest
                """
            }
        }
    }

    post {
        always {
            sh "docker logout public.ecr.aws/b0w0w8l4 || true"
        }
    }
}
