#  Blue-Green Deployment with Jenkins on Kind

This project demonstrates a full CI/CD pipeline using:

- **Kind** – Local Kubernetes cluster
- **Jenkins** – CI/CD pipeline orchestration
- **Helm** – Blue-green deployment strategy for a Node.js app

---

## 📁 Folder Structure

```
project-root/
├── cluster/
│   └── kind-config.yaml
├── jenkins/
│   ├── helm-values.yaml
│   ├── jenkisn-secret.yaml
│   └── jenkinsfile
├── nodejs-app/
│   ├── blue/
│   ├── green/
│   └── k8s/application
│       ├── charts/
│       ├── templates
│       │   ├── blue-deployment.yaml
│       │   ├── green-deployment.yaml
│       │   └── service.yaml  
│       ├── Charts.yaml  
│       └── values.yaml
├── scripts/
│   ├── create-cluster.sh
│   ├── deploy-jenkins.sh
│   ├── run-pipeline.sh
│   ├── switch-traffic.sh
└── README.md
```

---

## Prerequisites

Ensure the following tools are installed:

- `Docker`
- `kubectl`
- `kind`
- `helm`
- `git`

---

## 1. Create the Kind Cluster

Run this script to create the cluster:

```bash
./scripts/create-cluster.sh
```

This script uses `cluster/kind-config.yaml` to define the Kind cluster structure.

---

## 2. Deploy Jenkins

Use the following script to deploy Jenkins into the cluster:

```bash
./scripts/deploy-jenkins.sh
```

This will:
- Install Jenkins using Helm
- Apply admin credentials and pipeline job config from `jenkins/job-config/`

### Port Forward Jenkins
### Optional manaully create in case of not work since nodeport service will forward traffic correctly:
```bash
kubectl port-forward svc/jenkins -n jenkins 8080:8080
```

Open Jenkins UI at: [http://localhost:9081] or (http://localhost:8080)

---

## 3. Access Jenkins Admin Password

Run this command: or you have to go to inside pod using exec command and get password from this localtion /var/jenkins_home/secrets/initaladminpassword file.

```bash
kubectl exec -it -n jenkins $(kubectl get pod -n jenkins -l app.kubernetes.io/component=jenkins-controller -o jsonpath="{.items[0].metadata.name}") -- cat /var/jenkins_home/secrets/initialAdminPassword
```

---

## 4. Configure & Run Blue-Green Pipeline

### Option A: Auto-Configured Pipeline
If `blue-green-pipeline` is loaded via Helm values, your pipeline job is ready.


### Option B: Manually Create Pipeline Job
1. Open Jenkins UI
2. Create a **Pipeline** job named `blue-green-deploy`
3. Set pipeline definition to "Pipeline script from SCM"
4. Point to your Git repository and set path to:

```groovy
jenkins/jenkinsfile file with all pipeline stages.
```

---

## 5. Blue-Green Deployment Workflow

The pipeline will:

1. Clone your GitHub repo
2. Build and push Docker image to Docker Hub
3. Deploy app to `blue` or `green` namespace using Helm
4. Update service to point to the new version

Helm values are organized as:

- `nodejs-app/k8s/application/values.yaml`

---

## 6. Cleanup

To uninstall application chart:

```bash
helm uninstall application -n app-deploy
```

To uninstall jenkins chart:

```bash
helm uninstall jenkins -n jenkins
```

To delete the cluster:

```bash
kind delete cluster --name <your-cluster-name>
```

---





