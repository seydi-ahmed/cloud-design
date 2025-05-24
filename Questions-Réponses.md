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