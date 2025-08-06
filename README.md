# 🖨️ Système de Gestion d'Atelier d'Impression 3D - Odoo

Un système complet de gestion d'atelier d'impression 3D basé sur Odoo, incluant la gestion de stock de bobines et la centralisation des programmes d'impression.

## 📋 Vue d'ensemble du projet

Ce projet implémente deux modules principaux dans Odoo pour optimiser la gestion d'un atelier d'impression 3D :

### 🧵 **Module 1 : Gestion de Stock de Bobines**

Système de suivi précis des bobines de filament avec attributs détaillés et traçabilité individuelle.

### 🖨️ **Module 2 : Gestionnaire de Programmes 3D**

Module personnalisé pour centraliser et versionner les fichiers d'impression 3D (.gcode, .stl, .obj).

---

## 🎯 Objectifs

### Gestion des Bobines

- **Suivi individuel** de chaque bobine avec numéros de lots
- **Attributs détaillés** : poids, couleur, matière, diamètre
- **Traçabilité complète** des entrées/sorties de stock
- **Filtrage avancé** pour retrouver rapidement les bobines
- **Alertes de stock bas** selon les critères

### Gestion des Programmes

- **Centralisation** des fichiers d'impression 3D
- **Versioning** des programmes avec métadonnées
- **Upload sécurisé** de fichiers multiples formats
- **Recherche et filtrage** par extension, date, etc.
- **Historique** des modifications et imports

---

## 🏗️ Architecture technique

### 🐳 Environnement Docker

```
├── docker-compose.simple.yml    # Configuration Docker simplifiée
├── Dockerfile                   # Image Odoo personnalisée
├── requirements.txt            # Dépendances Python
└── config/
    └── odoo.conf              # Configuration Odoo
```

### 📦 Modules développés

```
addons/
└── 3d_program_manager/
    ├── __manifest__.py         # Métadonnées du module
    ├── models/
    │   └── printing_program.py # Modèle des programmes 3D
    ├── views/
    │   ├── printing_program_views.xml
    │   └── menu_views.xml
    └── security/
        └── ir.model.access.csv # Droits d'accès
```

---

## 🚀 Installation et démarrage

### Prérequis

- Docker & Docker Compose
- 4GB RAM minimum
- Git

### 1. Clone et configuration

```bash
git clone <repo-url>
cd "Odoo - Imprimante 3D"
cp env.example .env
# Modifiez .env avec vos paramètres
```

### 2. Démarrage des services

```bash
docker-compose -f docker-compose.simple.yml up -d
```

### 3. Configuration initiale Odoo

- Accédez à http://localhost:8069
- Créez la base de données `bobines_imprimante3d`
- Activez les modules : Inventaire, Ventes, Achats

### 4. Installation des modules personnalisés

- **Applications** → **Mettre à jour la liste des apps**
- **Rechercher** : "Gestionnaire de Programmes 3D"
- **Activer** le module

---

## 📊 Fonctionnalités implémentées

### ✅ Gestion des Bobines (Step 1)

#### Configuration des produits

- [x] Produit générique "Bobine Filament 3D"
- [x] Attributs configurés : Matière (PLA, ABS, PETG, TPU, etc.)
- [x] Attributs configurés : Couleur (Noir, Blanc, Rouge, etc.)
- [x] Attributs configurés : Diamètre (1.75mm, 2.85mm, 3.00mm)
- [x] Attributs configurés : Poids (250g, 500g, 1kg, 2kg, 5kg)

#### Traçabilité et stock

- [x] Gestion par numéros de lots
- [x] Emplacements de stock dédiés
- [x] Système de réception/sortie
- [x] Filtres de recherche avancés

#### Convention de nommage

```
Format: [MATIERE]-[COULEUR]-[DIAMETRE]-[NUMERO]
Exemples:
- PLA-ROUGE-175-001
- ABS-NOIR-285-001
- PETG-GRIS-175-001
```

### ✅ Gestionnaire de Programmes 3D (Step 2)

#### Modèle de données

- [x] Nom du programme (requis)
- [x] Version avec gestion des révisions
- [x] Date d'import automatique
- [x] Upload de fichiers binaires
- [x] Nom de fichier et extension auto-détectés
- [x] Calcul automatique de la taille
- [x] Notes et commentaires

#### Interface utilisateur

- [x] Vue liste avec colonnes triables
- [x] Vue formulaire d'édition complète
- [x] Filtres par type de fichier (.gcode, .stl, .obj)
- [x] Groupement par extension/version/date
- [x] Recherche globale dans tous les champs

#### Sécurité

- [x] Droits d'accès configurés
- [x] Stockage sécurisé des fichiers
- [x] Validation des uploads

---

## 🔧 Utilisation

### Gestion des Bobines

#### Ajouter une nouvelle bobine

1. **Inventaire** → **Opérations** → **Réceptions**
2. **Créer** une réception
3. **Sélectionner** le produit et la variante
4. **Générer** un numéro de lot unique
5. **Valider** la réception

#### Rechercher des bobines

1. **Inventaire** → **Produits** → **Lots/Numéros de série**
2. **Utiliser** les filtres par matière, couleur, etc.
3. **Consulter** les stocks disponibles

### Gestion des Programmes

#### Uploader un programme

1. **Impression 3D** → **Programmes**
2. **Créer** un nouveau programme
3. **Remplir** : nom, version, notes
4. **Uploader** le fichier (.gcode, .stl, .obj)
5. **Enregistrer** - les métadonnées se remplissent automatiquement

#### Organiser les programmes

- **Filtrer** par extension de fichier
- **Grouper** par version ou date
- **Rechercher** par nom ou contenu des notes
- **Trier** par date d'import ou taille

---

## 🔮 Améliorations futures

### Phase 3 - Intégrations avancées

- [ ] Lien programmes ↔ bobines utilisées
- [ ] Module de production avec nomenclatures
- [ ] Historique des impressions
- [ ] Calcul de coûts matière

### Phase 4 - Fonctionnalités avancées

- [ ] Visionneuse 3D intégrée pour fichiers STL
- [ ] API REST pour intégration externes
- [ ] Alertes intelligentes de stock
- [ ] Rapports et analytics d'utilisation

---

## 🛠️ Développement

### Structure du projet

```
├── step1.md                 # Spécifications gestion bobines
├── step2.md                 # Spécifications gestionnaire programmes
├── step3.md                 # Spécifications futures
├── README-Docker.md         # Documentation Docker détaillée
└── addons/                  # Modules Odoo personnalisés
```

### Commandes utiles

```bash
# Redémarrer Odoo
docker-compose -f docker-compose.simple.yml restart odoo

# Voir les logs
docker-compose -f docker-compose.simple.yml logs -f odoo

# Mettre à jour un module
# Interface Odoo → Applications → Rechercher → Mettre à jour
```

---

## 📞 Support et contributions

### Technologies utilisées

- **Odoo 17.0** - Framework ERP
- **PostgreSQL 15** - Base de données
- **Docker & Docker Compose** - Conteneurisation
- **Python 3.10** - Développement modules

### Développé pour

Ateliers d'impression 3D, FabLabs, makers, et entreprises utilisant l'impression 3D dans leur processus de production.

---

## 📄 Licence

Ce projet est sous licence LGPL-3, compatible avec les modules Odoo standard.

---

_Projet réalisé avec ❤️ pour optimiser les workflows d'impression 3D_
