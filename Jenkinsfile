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
