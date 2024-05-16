pipeline {
    agent any

    stages {
        stage('Cleanup Old Containers and Images') {
            steps {
                script {
                    // Assicurati che tutti i container legati a docker-compose siano fermati e rimossi
                    sh 'docker-compose down --rmi all || true'
                    // Rimuove tutti i container orfani che potrebbero non essere più necessari
                    sh 'docker container prune -f || true'
                    // Rimuove tutte le immagini non utilizzate per liberare spazio e prevenire conflitti di versione
                    sh 'docker image prune -af || true'
                }
            }
        }
        stage('Checkout') {
            steps {
                // Preleva il codice sorgente dal repository Git
                checkout scm
            }
        }

        stage('Build and Deploy') {
            steps {
                script {
                    // Usa Docker Compose per costruire e avviare i servizi con cache disabilitata per una build pulita
                    sh 'docker-compose --verbose up --build --no-cache -d'
                }
            }
        }
    }

    post {
        always {
            // Pulisci dopo la build, garantendo che i servizi non rimangano in esecuzione inutilmente
            sh 'docker-compose down'
            // Pulisce la workspace per rimuovere eventuali file residui
            cleanWs()
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
