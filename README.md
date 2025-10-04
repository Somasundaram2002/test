# Minimal CI/CD practice

- One Node module (greeter) + two Jest unit tests.
- Jenkins pipeline: checkout -> npm ci -> npm test (JUnit) -> buildx build -> push image.
- Commands:
  npm ci && npm test
  docker build -t your-dockerhub-username/ci-cd-minimal:dev .
