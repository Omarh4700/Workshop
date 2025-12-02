pipeline {
    agent any

    environment {
        REGION             = "us-east-1"

        // Public ECR repo
        ECR_DB             = "public.ecr.aws/b0w0w8l4/vp-app-db"

        BRANCH             = "beta"
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

        stage('Decrypt DB Backup') {
            steps {
                script {
                    dir('K8s/Dockerfile/db') {
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
                                    echo "❌ Decryption failed!"
                                    exit 1
                                fi
                                
                                echo "✅ Database backup decrypted successfully"
                            '''
                        }
                    }
                }
            }
        }

        stage('Build & Push DB Image') {
            steps {
                script {
                    dir('K8s/Dockerfile/db') {
                        sh """
                        docker build -t ${ECR_DB}:${GIT_SHA} -t ${ECR_DB}:latest .
                        docker push ${ECR_DB}:${GIT_SHA}
                        docker push ${ECR_DB}:latest
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                dir('K8s/Dockerfile/db') {
                    // Clean up decrypted SQL file for security
                    sh 'rm -f db_backup.sql'
                }
            }
            // Logout from ECR
            sh "docker logout public.ecr.aws/b0w0w8l4 || true"
            
            // Clean up local images to save disk space
            sh """
                docker rmi ${ECR_DB}:${GIT_SHA} || true
                docker rmi ${ECR_DB}:latest || true
            """
        }
        success {
            echo " DB image built and pushed successfully!"
            echo "   - DB: ${ECR_DB}:${GIT_SHA}"
            echo "   - DB: ${ECR_DB}:latest"
        }
        failure {
            echo " Build or push failed!"
        }
    }
}
