pipeline {
agent {
docker {
image 'node:18-alpine'
args '-u root:root'
}
}
options {
timestamps()
timeout(time: 15, unit: 'MINUTES')
}
environment {
DOCKER_BUILDKIT = '1'
IMAGE = 'your-dockerhub-username/ci-cd-minimal'
}
stages {
stage('Checkout') {
steps {
checkout scm
}
}
stage('Install & Test') {
steps {
sh 'node -v && npm -v'
sh 'npm ci'
sh 'npm test'
}
post {
always {
junit allowEmptyResults: true, testResults: 'reports/junit/junit.xml'
}
}
}
stage('Build & Push Image') {
steps {
sh 'docker buildx create --use || true'
script {
def tag = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
sh 'echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin'
}
sh "docker buildx build --platform linux/amd64 -t ${IMAGE}:${tag} --push ."
}
}
}
}
}
