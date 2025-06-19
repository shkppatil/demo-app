helm repo add jenkins https://charts.jenkins.io
helm repo update

helm install jenkins jenkins/jenkins -f jenkins/helm-values.yaml -f jenkins-secret.yaml --namespace jenkins
