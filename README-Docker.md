# 🐳 Odoo Imprimante 3D - Configuration Docker

Ce projet utilise Docker pour faciliter le déploiement d'Odoo avec des modules personnalisés pour la gestion d'imprimantes 3D.

## 📋 Prérequis

- Docker (version 20.10+)
- Docker Compose (version 2.0+)
- Au moins 4GB de RAM disponible

## 🚀 Installation rapide

### 1. Cloner et préparer l'environnement

```bash
git clone <votre-repo>
cd "Odoo - Imprimante 3D"
```

### 2. Configuration des variables d'environnement

Copiez le fichier d'exemple et personnalisez-le :

```bash
cp env.example .env
```

Modifiez `.env` avec vos paramètres :

- Changez les mots de passe par défaut
- Ajustez les ports si nécessaire

**Variables importantes à personnaliser :**

```bash
POSTGRES_PASSWORD=votre_mot_de_passe_securise
ODOO_ADMIN_PASSWORD=votre_master_password_securise
ODOO_PORT=8069  # Changez si le port est déjà utilisé
```

### 3. Démarrage des services

```bash
# Construction et démarrage
docker-compose up -d --build

# Vérifier les logs
docker-compose logs -f odoo
```

### 4. Accès à l'application

- **Interface web** : http://localhost:8069
- **Base de données** : localhost:5432

## 🔧 Configuration initiale d'Odoo

1. Rendez-vous sur http://localhost:8069
2. Complétez le formulaire de première installation :
   - **Master Password** : utilisez celui défini dans votre `.env`
   - **Database Name** : `odoo_imprimante3d`
   - **Email** : votre email d'administrateur
   - **Password** : mot de passe fort pour votre compte
   - **Language** : Français
   - **Country** : France

## 📁 Structure du projet

```
├── Dockerfile              # Image Docker personnalisée
├── docker-compose.yml      # Orchestration des services
├── requirements.txt        # Dépendances Python
├── config/
│   └── odoo.conf           # Configuration Odoo
├── addons/                 # Modules personnalisés
├── logs/                   # Logs d'application
└── README-Docker.md        # Cette documentation
```

## 🛠️ Développement

### Ajouter un module personnalisé

1. Créez votre module dans le dossier `addons/`
2. Redémarrez le conteneur :
   ```bash
   docker-compose restart odoo
   ```
3. Activez le module depuis l'interface Odoo

### Commandes utiles

```bash
# Redémarrer uniquement Odoo
docker-compose restart odoo

# Voir les logs en temps réel
docker-compose logs -f

# Accéder au shell du conteneur
docker-compose exec odoo bash

# Mise à jour des modules
docker-compose exec odoo odoo -d odoo_imprimante3d -u all --stop-after-init

# Sauvegarde de la base de données
docker-compose exec db pg_dump -U odoo odoo_imprimante3d > backup.sql
```

## 🔒 Sécurité

**⚠️ Important pour la production :**

1. Changez tous les mots de passe par défaut
2. Modifiez le `admin_passwd` dans `config/odoo.conf`
3. Désactivez le mode développement
4. Configurez un reverse proxy (nginx)
5. Utilisez HTTPS

## 📦 Modules recommandés pour imprimante 3D

- **Inventaire** : Gestion des filaments et pièces
- **Projet** : Suivi des impressions
- **CRM** : Gestion des clients
- **Comptabilité** : Facturation des services

## 🐛 Dépannage

### Le conteneur ne démarre pas

```bash
# Vérifier les logs
docker-compose logs odoo
docker-compose logs db

# Reconstruire l'image
docker-compose down
docker-compose up --build
```

### Problème de permissions

```bash
# Corriger les permissions
sudo chown -R 101:101 ./addons
sudo chown -R 101:101 ./logs
```

### Base de données corrompue

```bash
# Supprimer le volume et recommencer
docker-compose down -v
docker-compose up -d
```

## 📞 Support

Pour toute question technique, consultez :

- [Documentation officielle Odoo](https://www.odoo.com/documentation)
- [Guide Docker belginux](https://belginux.com/installer-odoo-avec-docker/)
