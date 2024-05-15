pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Preleva il codice sorgente dal repository Git
                checkout scm
            }
        }

        stage('Build and Deploy') {
            steps {
                script {
                    // Usa Docker Compose per costruire e avviare i servizi
                    sh 'docker-compose up --build -d'
                }
            }
        }
    }

    post {
        always {
            // Pulisci dopo la build
            // sh 'docker-compose down'
            // cleanWs()
        }
        success {
            // Notifiche o ulteriori passaggi in caso di successo
            echo 'Deployment successful!'
        }
        failure {
            // Notifiche o ulteriori passaggi in caso di fallimento
            echo 'Deployment failed.'
        }
    }
}
