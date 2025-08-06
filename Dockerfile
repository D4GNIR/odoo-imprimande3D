# Image de base Odoo officielle
FROM odoo:17.0

# Métadonnées
LABEL maintainer="Votre nom <votre.email@example.com>"
LABEL description="Odoo pour la gestion d'imprimante 3D"

# Variables d'environnement
ENV ODOO_RC /etc/odoo/odoo.conf

# Passer en utilisateur root pour installer des dépendances
USER root

# Installer des dépendances système supplémentaires si nécessaire
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Copier les requirements Python personnalisés
COPY requirements.txt /tmp/requirements.txt

# Installer les dépendances Python supplémentaires
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

# Créer le répertoire pour les addons personnalisés
RUN mkdir -p /mnt/extra-addons

# Copier les modules personnalisés
COPY ./addons /mnt/extra-addons/

# Copier la configuration Odoo personnalisée
COPY ./config/odoo.conf /etc/odoo/

# Donner les bonnes permissions
RUN chown -R odoo:odoo /mnt/extra-addons
RUN chown -R odoo:odoo /etc/odoo

# Revenir à l'utilisateur odoo
USER odoo

# Exposer le port Odoo
EXPOSE 8069

# Commande par défaut
CMD ["odoo"]