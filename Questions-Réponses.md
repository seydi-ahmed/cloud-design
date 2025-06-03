# Projet Cloud - FAQ Technique

## 1. Qu'est-ce que le cloud et ses avantages ?
**Réponse :**  
Le cloud computing est la fourniture de services informatiques (serveurs, stockage, bases de données, etc.) via Internet.  
**Avantages clés :**
- Évolutivité instantanée
- Réduction des coûts d'infrastructure
- Accès global aux ressources
- Maintenance gérée par le fournisseur
- Haute disponibilité

## 2. Pourquoi déployer dans le cloud plutôt qu'on-premise ?
**Réponse :**  
Le cloud est préféré car il offre :
- Temps de déploiement réduit
- Coûts opérationnels prévisibles (OPEX vs CAPEX)
- Capacité à gérer des pics de charge
- Mises à jour automatiques
- Meilleure résilience globale

## 3. Différences entre cloud public, privé et hybride
**Réponse :**
- **Public** : Ressources partagées (AWS, Azure)
- **Privé** : Infrastructure dédiée (OpenStack, VMware)
- **Hybride** : Combinaison des deux modèles

## 4. Pourquoi avoir choisi AWS pour ce projet ?
**Réponse :**  
Critères de sélection :
- Leader du marché avec une large gamme de services
- Compatibilité avec Kubernetes (EKS)
- Modèle de tarification flexible
- Certification PCI DSS pour la sécurité
- Expérience préalable de l'équipe

## 5. Architecture microservices sur AWS
**Schéma d'architecture :**
```
Utilisateur → ALB → API Gateway → [Microservices]
↓
(ECS/EKS avec Fargate)
↓
(RDS Aurora, ElastiCache, S3)
```


## 6. Gestion des coûts AWS
**Optimisations :**
- Instances Spot pour les workloads non critiques
- Politiques d'auto-scaling bien calibrées
- Monitoring avec AWS Cost Explorer
- Arrêt automatique des environnements de test

## 7. Sécurité de l'application
**Mesures implémentées :**
- IAM avec moindres privilèges
- Chiffrement des données (KMS)
- Security Groups restrictifs
- Scan des vulnérabilités avec Inspector
- Conformité au modèle de responsabilité partagée AWS

## 8. Outils de monitoring
**Stack utilisée :**
- **CloudWatch** : Métriques et alertes
- **X-Ray** : Traçage des requêtes
- **GuardDuty** : Détection des menaces
- **Prometheus+Grafana** : Dashboard personnalisés

## 9. Politiques d'auto-scaling
**Configuration :**
- Scaling horizontal basé sur CPU (60-80%)
- Pré-chauffage des instances (warm-up)
- Scaling progressif (step policies)
- Pool d'instances multi-AZ

## 10. Optimisation des images Docker
**Bonnes pratiques :**
- Images Alpine pour taille réduite
- Multi-stage builds
- .dockerignore bien configuré
- Scan des vulnérabilités avec Trivy
- Réduction moyenne de 40% de la taille des images

## 11. Améliorations potentielles
**Si c'était à refaire :**
- Migration vers EKS au lieu d'ECS
- Intégration plus poussée de Serverless
- Infrastructure as Code avec CDK au lieu de Terraform
- Plus de tests de chaos engineering

## 12. Évolutivité future
**Extensions possibles :**
- Ajout de services via API Gateway
- Migration multi-cloud avec Anthos
- Intégration de services ML (SageMaker)
- Adoption de service mesh (App Mesh)

## 13. Défis rencontrés
**Problèmes majeurs :**
- Latence inter-AZ → Optimisation VPC Peering
- Gestion des secrets → Migration à Secrets Manager
- Coûts imprévus → Mise en place de budgets

## 14. Documentation
**Approche adoptée :**
- Diagrammes d'architecture avec Draw.io
- Documentation versionnée avec le code
- Exemples de commandes pour chaque opération
- Playbook d'urgence pour les incidents