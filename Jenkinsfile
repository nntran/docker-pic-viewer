pipeline {
    agent any
    environment {
        PROJECT_NAME = 'pic-viewer'
        SLACK_CHANNEL = 'ntdtgroupe.slack.com'
        SWARM_MANAGER_IP = '8.8.8.8'
        SWARM_WORKER_1_IP = '1.1.1.1'
        SWARM_WORKER_2_IP = '2.2.2.2'
        TLS_CA = '/var/lib/jenkins/TLS/swarm/ca.pem'
        TLS_CERT = '/var/lib/jenkins/TLS/swarm/cert.pem'
        TLS_KEY = '/var/lib/jenkins/TLS/swarm/key.pem'
        DOCKER_HUB_ID = 'ntdtfr'
    }
    stages {
        stage ('Init env') {
            steps {
                sh "echo 'Auth to image repo'"
                //sh "eval \$(aws ecr get-login --profile ${PROFILE} --no-include-email) &>/dev/null"
            }
        }
        stage ('Build image'){
            steps{
                script{
                    withDockerServer([uri:'tcp://127.0.0.1:2376']) {
                        sh "cp ./.jenkins/Dockerfile ./Dockerfile"
                        echo "Debug: Building  with ${DOCKER_HUB_ID}:${PROJECT_NAME}-${JOB_BASE_NAME}-${BUILD_NUMBER}"
                        def image = docker.build ("${DOCKER_HUB_ID}:${PROJECT_NAME}-${JOB_BASE_NAME}-${BUILD_NUMBER}")
                        image.push ()
                        echo "Debug: After push to registry"
                    }
                }
            }
        }
        stage ('Deploy Pic-Viewer on Staging') {
            when { branch 'staging' }
            steps {
                sh 'envsubst < ".jenkins/deploy/staging.yml" > "staging.yml"'
                //sh "ssh ubuntu@${SWARM_WORKER_1_IP} 'sudo docker pull ${DOCKER_HUB_ID}:${PROJECT_NAME}-${JOB_BASE_NAME}-${BUILD_NUMBER}'"
                //sh "ssh ubuntu@${SWARM_WORKER_2_IP} 'sudo docker pull ${DOCKER_HUB_ID}:${PROJECT_NAME}-${JOB_BASE_NAME}-${BUILD_NUMBER}'"
                //sh "docker -H tcp://${SWARM_MANAGER_IP}:2376 --tlsverify --tlscacert=${TLS_CA} --tlscert=${TLS_CERT} --tlskey=${TLS_KEY} stack deploy --compose-file staging.yml training"
            }
        }
        stage ('Deploy Pic-Viewer on Production') {
            when { branch 'production' }
            steps {
                sh 'envsubst < ".jenkins/deploy/production.yml" > "production.yml"'
                //sh "ssh ubuntu@${SWARM_WORKER_1_IP} 'sudo docker pull ${DOCKER_HUB_ID}:${PROJECT_NAME}-${JOB_BASE_NAME}-${BUILD_NUMBER}'"
                //sh "ssh ubuntu@${SWARM_WORKER_2_IP} 'sudo docker pull ${DOCKER_HUB_ID}:${PROJECT_NAME}-${JOB_BASE_NAME}-${BUILD_NUMBER}'"
                //sh "docker -H tcp://${SWARM_MANAGER_IP}:2376 --tlsverify --tlscacert=${TLS_CA} --tlscert=${TLS_CERT} --tlskey=${TLS_KEY} stack deploy --compose-file production.yml training"
            }
        }
    }
    post {
        success {
            slackSend channel: "${SLACK_CHANNEL}", color: 'good', message: "Job: ${JOB_NAME}${BUILD_NUMBER} build was successful."
        }
        failure {
            slackSend channel: "${SLACK_CHANNEL}", color: 'danger', message: "Job: ${JOB_NAME}${BUILD_NUMBER} was finished with some error. It may occurs because of the build was rollbacked by docker swarm, or because of other error (watch the Jenkins Console Output): ${JOB_URL}${BUILD_ID}/consoleFull"
        }
        unstable {
            slackSend channel: "${SLACK_CHANNEL}", color: 'warning', message: "Job: ${JOB_NAME}${BUILD_NUMBER} was finished with some error. Please watch the Jenkins Console Output: ${JOB_URL}${BUILD_ID}/console."
        }
    }
}