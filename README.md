# Cloud-Design

## Ce qu'on a ajouté par rapport au projet précédent

### 🔧 Infrastructure (Terraform) – terraform/
- Gère le cluster EKS, le réseau (VPC), les groupes de nœuds, et les IAM roles
- Dossier eks/ pour le cluster EKS
- Dossier networking/ pour VPC + sécurité

### ☁️ Manifests spécifiques EKS – eks-manifests/
- alb-ingress.yaml: ingress via AWS Load Balancer Controller
- external-secrets.yaml: secrets gérés par AWS Secrets Manager
- eks-sa.yaml: IAM roles pour ServiceAccounts
- kustomization.yaml (si tu utilises kustomize)

### 📊 Monitoring AWS/K8s – monitoring/
- Prometheus / Grafana configs (*-values.yaml)
- Agent CloudWatch: cloudwatch-agent-config.json

## Ordre de remplissage des fichiers (recommandé pour débutant AWS/Terraform)
### Étape 1 – Infrastructure AWS avec Terraform
- ➡️ Objectif : Déployer EKS + VPC + IAM + NodeGroup
    - infrastructure/terraform/provider.tf (définir AWS provider + région)
    - infrastructure/terraform/variables.tf (variables de base : région, cluster name, etc.)
    - infrastructure/terraform/main.tf (module loader)
    - infrastructure/eks/vpc.tf (VPC + subnets)
    - infrastructure/eks/cluster.tf (cluster EKS)
    - infrastructure/eks/eks-nodegroup.tf (node groups autoscaling)
    - infrastructure/iam/iam-roles.tf (IAM roles pour EKS + nodes)
    - infrastructure/networking/security-groups.tf (ouvrir ports pour services)
    - infrastructure/terraform/outputs.tf (sorties utiles pour le cluster)

### Étape 2 – Conteneurs et Kubernetes
- ➡️ Objectif : Déployer app sur EKS
    - scripts/build-images.sh (builder les images localement)
    - scripts/push-images.sh (pusher sur DockerHub ou ECR)
    - kubernetes/manifests/* (services, déploiements, ingress, secrets, etc.)
    - kubernetes/kustomize/kustomization.yaml (optionnel, si overlay nécessaire)

### Étape 3 – Monitoring et Observabilité
- ➡️ Objectif : Mettre en place des dashboards et alertes
    - monitoring/prometheus.yaml (scraper les métriques)
    - monitoring/cloudwatch/cloudwatch-agent-config.json (logs + métriques de base)
    - monitoring/grafana-dashboards/ (dashboards JSON ou template Grafana)

### tape 4 – Documentation et Finalisation
- ➡️ Objectif : Documenter le projet pour l’audit final
    - README.md (architecture, setup, diagrammes)
    - infrastructure/README.md (infra détaillée, modules)
    - monitoring/README.md (logs, alertes, dashboards)

## Structure de notre projet:
```
.
├── docker
│   ├── api-gateway-app
│   │   └── Dockerfile
│   ├── billing-app
│   │   └── Dockerfile
│   ├── inventory-app
│   │   └── Dockerfile
│   ├── postgres-db
│   │   └── Dockerfile
│   └── rabbitmq
│       └── Dockerfile
├── docs
├── infrastructure
│   ├── eks
│   │   ├── cluster.tf
│   │   ├── eks-nodegroup.tf
│   │   └── vpc.tf
│   ├── iam
│   │   └── iam-roles.tf
│   ├── networking
│   │   └── security-groups.tf
│   ├── README.md
│   └── terraform
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       └── variables.tf
├── kubernetes
│   ├── kustomize
│   │   └── kustomization.yaml
│   └── manifests
│       ├── api-gateway-app
│       │   ├── deployment.yaml
│       │   ├── hpa.yaml
│       │   └── service.yaml
│       ├── billing-app
│       │   ├── service.yaml
│       │   └── statefulset.yaml
│       ├── configmaps
│       │   └── app-config.yaml
│       ├── databases
│       │   ├── billing-db.yaml
│       │   └── inventory-db.yaml
│       ├── ingress
│       │   └── ingress.yaml
│       ├── inventory-app
│       │   ├── deployment.yaml
│       │   ├── hpa.yaml
│       │   └── service.yaml
│       ├── rabbitmq
│       │   ├── deployment.yaml
│       │   └── service.yaml
│       └── secrets
│           ├── billing-db-secret.yaml
│           ├── inventory-db-secret.yaml
│           └── rabbitmq-secret.yaml
├── monitoring
│   ├── cloudwatch
│   │   └── cloudwatch-agent-config.json
│   ├── grafana-dashboards
│   ├── {prometheus.yaml}
│   └── README.md
├── Questions-Réponses.md
├── README.md
├── scripts
│   ├── build-images.sh
│   ├── deploy-all.sh
│   └── push-images.sh
└── srcs
    ├── api-gateway-app
    │   ├── app
    │   │   ├── __init__.py
    │   │   ├── proxy.py
    │   │   └── queue_sender.py
    │   ├── Dockerfile
    │   ├── requirements.txt
    │   └── server.py
    ├── billing-app
    │   ├── app
    │   │   ├── consume_queue.py
    │   │   └── orders.py
    │   ├── Dockerfile
    │   ├── requirements.txt
    │   └── server.py
    ├── inventory-app
    │   ├── app
    │   │   ├── extensions.py
    │   │   ├── __init__.py
    │   │   └── movies.py
    │   ├── Dockerfile
    │   ├── requirements.txt
    │   └── server.py
    ├── postgres-db
    │   ├── Dockerfile
    │   └── tools
    │       └── setup_db.sh
    └── rabbitmq
        ├── Dockerfile
        └── tools
            └── setup_rq.sh
```