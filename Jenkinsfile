/*
pipeline {
    agent any

    environment {
      PROJECT_NAME = "car-management-app"
    }

    stages {
        stage('Cloner le dépôt ') {
            steps {
                checkout scm
            }
        }

        stage('Construire et lancer les services') {
            steps {
                script {
                    // Arrêt et suppression des conteneurs en cours
                    bat 'docker compose down --remove-orphans'
                    bat 'docker compose down -v '

                    // Reconstruire toutes les images et relancer les services
                    bat 'docker compose up --build -d'
                }
            }
        }
    }

    post {
        success {
            echo 'Déploiement réussi via Docker Compose.'
        }
        failure {
            echo 'Échec du pipeline.'
        }
    }
}
*/
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
                echo 'Clonage du dépôt..'
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
                    bat 'npm run build -- --configuration production'
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Lancement des tests backend...'
                dir('backend') {
                    bat 'mvn test'
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
            echo 'Pipeline terminé avec succès !'
        }
        failure {
            echo 'Échec du pipeline.'
        }
    }
}


