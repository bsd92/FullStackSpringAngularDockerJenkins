pipeline {
    agent any

    environment {
        BACKEND_IMAGE = 'spring-backend'
        FRONTEND_IMAGE = 'angular-frontend'
    }

    stages {
        stage('Cloner le repository') {
            steps {
                checkout scm
            }
        }

        stage('Build Backend') {
            steps {
                dir('backend') {
                    bat 'mvn clean package -DskipTests'
                    bat 'docker build -t %BACKEND_IMAGE% .'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                dir('frontend') {
                    bat 'npm install'
                    bat 'npm run build --prod'
                    bat 'docker build -t %FRONTEND_IMAGE% .'
                }
            }
        }

        stage('Run Containers') {
            steps {
                bat 'docker rm -f spring-backend || true'
                bat 'docker rm -f angular-frontend || true'

                bat 'docker run -d -p 8080:8080 --name spring-backend %BACKEND_IMAGE%'
                bat 'docker run -d -p 80:80 --name angular-frontend %FRONTEND_IMAGE%'
            }
        }
    }

    post {
        success {
            echo 'Déploiement réussi '
        }
        failure {
            echo 'Échec du pipeline '
        }
    }
}
