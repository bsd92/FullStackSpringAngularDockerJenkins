pipeline {
    agent any

    environment {
        SPRING_JAR = 'backend/target/garage-0.0.1-SNAPSHOT.jar'
        ANGULAR_DIST = 'frontend/dist'
        PROJECT_NAME = 'car-management-app'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Clonage du dépôt...'
                checkout scm
            }
        }

        stage('Build Backend') {
            steps {
                echo 'Compilation du backend Spring Boot..'
                dir('backend') {
                    bat 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                echo 'Compilation du frontend Angular...'
                dir('frontend') {
                    bat 'npm install'
                    //Active le profile test uniquement pour les tests unitaires
                    bat 'npm run build -- --configuration production'
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Lancement des tests backend...'
                dir('backend') {
                    bat 'mvn test -Dspring.profiles.active=test'

                }
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                echo 'Déploiement avec Docker Compose...'
                bat 'docker compose down -v --remove-orphans'
                bat 'docker compose down -v'
                bat 'docker compose up --build -d'
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminé avec succès!'
        }
        failure {
            echo 'Échec du pipeline.'
        }
    }
}


