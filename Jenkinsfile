stage('Install & Test') {
  steps {
    sh 'node -v && npm -v'      // sanity check
    sh 'npm ci'
    sh 'npm test'
  }
  post {
    always {
      // if using jest-junit, point this to your report path
      junit allowEmptyResults: true, testResults: 'reports/junit/junit.xml'
    }
  }
}

stage('Build & Push') {
  steps {
    // switch out of the node container context to use host Docker if needed:
    // if Jenkins is on a host with Docker socket mounted, this works;
    // otherwise run a separate Docker-in-Docker stage/agent.
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
