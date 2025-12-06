pipeline {
    agent any

    environment {
        REGION             = "us-east-1"
        ECR_DB             = "public.ecr.aws/r7l3n7g0/vp-app-db"
        ECR_TOMCAT         = "public.ecr.aws/r7l3n7g0/vp-app-tomcat"
        BRANCH             = "vProfile-Microservices"
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
                | docker login --username AWS --password-stdin public.ecr.aws/r7l3n7g0
                """
            }
        }

        stage('Decrypt DB Backup') {
            steps {
                script {
                    dir('application-data/db') {
                        // Get encryption key from Jenkins Credentials
                        withCredentials([
                            string(credentialsId: 'db-encryption-key', variable: 'ENCRYPTION_KEY')
                        ]) {
                            sh '''
                                # Decrypt the SQL file
                                openssl enc -aes-256-cbc -d -pbkdf2 \
                                    -in db_backup.sql.enc \
                                    -out db_backup.sql \
                                    -k "${ENCRYPTION_KEY}"
                                
                                # Verify decryption succeeded
                                if [ ! -f db_backup.sql ]; then
                                    echo "Decryption failed!"
                                    exit 1
                                fi
                                
                                echo "Database backup decrypted successfully"
                            '''
                        }
                    }
                }
            }
        }

        stage('Build & Push DB Image') {
            steps {
                script {
                    dir('application-data/db') {
                        sh """
                        docker build -t ${ECR_DB}:${GIT_SHA} -t ${ECR_DB}:latest .
                        docker push ${ECR_DB}:${GIT_SHA}
                        docker push ${ECR_DB}:latest
                        """
                    }
                }
            }
        }

        stage('Decrypt Tomcat App Config') {
            steps {
                script {
                    dir('application-data/tomcat') {
                        withCredentials([
                            string(credentialsId: 'app-encryption-key', variable: 'ENCRYPTION_KEY')
                        ]) {
                            sh '''
                                openssl enc -aes-256-cbc -d -pbkdf2 \
                                    -in application.properties.enc \
                                    -out application.properties \
                                    -k "${ENCRYPTION_KEY}"
                                
                                if [ ! -f application.properties ]; then
                                    echo "Decryption failed!"
                                    exit 1
                                fi
                                
                                echo "App config decrypted successfully"
                            '''
                        }
                    }
                }
            }
        }

        stage('Build & Push Tomcat Image') {
            steps {
                script {
                    dir('application-data/tomcat') {
                        sh """
                        docker build -t ${ECR_TOMCAT}:${GIT_SHA} -t ${ECR_TOMCAT}:latest .
                        docker push ${ECR_TOMCAT}:${GIT_SHA}
                        docker push ${ECR_TOMCAT}:latest
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                dir('application-data/db') {
                    // Clean up decrypted SQL file for security
                    sh 'rm -f db_backup.sql'
                }
                dir('application-data/tomcat') {
                    // Clean up decrypted properties file for security
                    sh 'rm -f application.properties'
                }
            }
            // Logout from ECR
            sh "docker logout public.ecr.aws/r7l3n7g0 || true"
            
            // Clean up local images to save disk space
            sh """
                docker rmi ${ECR_DB}:${GIT_SHA} || true
                docker rmi ${ECR_DB}:latest || true
                docker rmi ${ECR_TOMCAT}:${GIT_SHA} || true
                docker rmi ${ECR_TOMCAT}:latest || true
            """
        }
        success {
            echo " Images built and pushed successfully!"
            echo "   - DB: ${ECR_DB}:${GIT_SHA}"
            echo "   - DB: ${ECR_DB}:latest"
            echo "   - Tomcat: ${ECR_TOMCAT}:${GIT_SHA}"
            echo "   - Tomcat: ${ECR_TOMCAT}:latest"
        }
        failure {
            echo " Build or push failed!"
        }
    }
}
