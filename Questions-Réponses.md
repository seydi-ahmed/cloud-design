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

