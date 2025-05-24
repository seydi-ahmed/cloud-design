# Questions / Réponses:

## ✅ Fichier 1 : provider.tf:
- Ce fichier configure le fournisseur Terraform — c’est-à-dire l’interface entre Terraform et AWS.
- terraform.required_providers dit à Terraform : “Je vais utiliser AWS, et je veux telle version du plugin.”
- provider "aws" dit comment se connecter à AWS :
    - La région dans laquelle on déploie.
    - Le profil AWS CLI à utiliser (c’est ce que tu as configuré avec aws configure).
- C’est le point de départ de toute infrastructure AWS avec Terraform.

## ✅ Fichier 2 : variables.tf:
- Ce fichier définit les variables qu'on peut personnaliser dans d'autres fichiers .tf.
- Tu peux voir ça comme les “paramètres” de ton infrastructure.

## ✅ Fichier 3 : main.tf
- Ce fichier est le cœur du projet Terraform. Il fait “le lien” entre le code Terraform racine (terraform/) et tous les autres sous-modules (VPC, EKS, IAM, etc.).
- Mais dans ce cas, nous avons tout centralisé dans un seul projet (pas de modules réutilisables externes ou internes), ce fichier va juste charger les autres .tf comme s'ils étaient un seul gros fichier.

## ✅ Fichier 4 : infrastructure/eks/vpc.tf
- Ce fichier crée le réseau fondamental de ton infrastructure AWS.
- Il définit:
    - un VPC (Virtual Private Cloud)
    - des subnets publics et privés
    - une gateway internet (pour sortir sur Internet)
    - les routes nécessaires
    - des tags pour qu’EKS identifie automatiquement le réseau
- 💬 Explication rapide:
    - aws_vpc: crée ton propre réseau privé sur AWS.
    - aws_internet_gateway: permet à tes instances d'accéder à Internet.
    - aws_subnet: sous-réseaux dans deux AZ (zones de dispo) différentes.
    - map_public_ip_on_launch: donne des IP publiques à tes instances dans ces subnets.
    - route_table: configure une route vers Internet pour ces subnets.
    - les tags kubernetes.io sont requis pour qu’EKS les détecte comme subnets éligibles.

## ✅ Fichier 5 : infrastructure/eks/cluster.tf
- Ce fichier crée le cluster EKS lui-même.
- C’est ici qu’on dit à AWS : “Je veux un cluster Kubernetes managé (EKS) dans le VPC qu’on vient de créer.”
- 💬 Explication rapide:
    - aws_eks_cluster: crée un cluster Kubernetes managé.
    - name: nom du cluster (venant de la variable).
    - role_arn: le rôle IAM utilisé par le control plane du cluster (sera défini dans iam-roles.tf).
    - subnet_ids: les deux subnets publics créés dans vpc.tf (zones où les nodes seront déployés).
    - endpoint_public_access: active l’accès public à l’API Kubernetes (nécessaire pour ton PC local ou CloudShell).
    - depends_on: assure que la policy IAM est bien attachée avant la création du cluster.

## ✅ Fichier 6 : infrastructure/eks/eks-nodegroup.tf
- Ce fichier ajoute les “workers” à ton cluster EKS : ce sont les nœuds EC2 qui exécutent les pods.
- On utilise ici les node groups managés par AWS (avec autoscaling intégré).
- 💬 Explication rapide:
    - aws_eks_node_group: groupe d’EC2 managés par AWS.
    - scaling_config: permet d’ajuster automatiquement le nombre de nœuds entre 1 et 3.
    - instance_types: type d’EC2 utilisé. Ici : t3.medium, un bon point de départ.
    - remote_access.ec2_ssh_key: permet d’accéder aux EC2 via SSH. (Il faut créer une Key Pair sur AWS EC2 et renseigner son nom dans variables.tf via ec2_key_pair).
    - depends_on: garantit que le cluster + rôles IAM sont prêts avant la création du node group.

## ✅ Fichier 7 : infrastructure/iam/iam-roles.tf
- Ce fichier définit les rôles IAM nécessaires pour qu'AWS autorise:
    - EKS à gérer le cluster,
    - Les EC2 (nœuds du cluster) à communiquer avec EKS et tirer les images Docker, etc.
- Sans ces rôles, le cluster EKS ne pourra rien faire.
- 💬 Explication rapide
    - 🎯 eks_cluster_role
        - Permet à EKS de créer/manager le cluster et ses composants.
    - 🎯 eks_node_role
        - Permet aux EC2 nodes d’accéder à:
            - Kubernetes (via EKSWorkerNodePolicy)
            - La gestion réseau CNI (via AmazonEKS_CNI_Policy)
            - DockerHub ou ECR (via EC2ContainerRegistryReadOnly)

## ✅ Fichier 8 : infrastructure/networking/security-groups.tf
- Ce fichier définit un Security Group (SG) qui agit comme un pare-feu : il autorise ou bloque le trafic réseau entrant et sortant pour les ressources (comme les pods ou les services).
- 💬 Explication rapide
    - Ingress (entrant):
        - Autorise:
            - HTTP (port 80)
            - HTTPS (port 443)
            - SSH (port 22)
            - Tout le trafic interne au VPC (important pour communication inter-services)
    - Egress (sortant):
        - Autorise tout (nécessaire pour que les pods puissent faire des requêtes sortantes : accès à DockerHub, API tierces, etc.)