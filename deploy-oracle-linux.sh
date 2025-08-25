#!/bin/bash
# 🚀 Script de déploiement Odoo sur Oracle Linux 9

echo "🌟 Déploiement Odoo Imprimante 3D sur Oracle Linux"
echo "================================================="

# Mise à jour du système
echo "📦 Mise à jour du système..."
sudo dnf update -y

# Installation des outils de base
echo "🔧 Installation des outils..."
sudo dnf install -y git curl wget

# Installation Docker
echo "🐳 Installation Docker..."
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Installation Docker Compose standalone
echo "🔗 Installation Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Configuration firewall Oracle Linux
echo "🔥 Configuration firewall..."
sudo firewall-cmd --permanent --add-port=8069/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload

# Clone du projet
echo "📂 Téléchargement du projet..."
cd ~
git clone https://github.com/D4GNIR/odoo-imprimande3D.git
cd odoo-imprimande3D

# Configuration des variables d'environnement
echo "⚙️ Configuration..."
cat > .env << EOF
# Configuration Odoo pour Oracle Cloud
POSTGRES_DB=odoo_imprimante3d
POSTGRES_USER=odoo
POSTGRES_PASSWORD=$(openssl rand -base64 32)
ODOO_ADMIN_PASSWORD=$(openssl rand -base64 32)
ODOO_PORT=8069
POSTGRES_PORT=5432
ODOO_WORKERS=0
ODOO_LOG_LEVEL=info
EOF

# Permissions
sudo chown -R $USER:$USER ~/odoo-imprimante3D

# Création du script de démarrage
cat > start-odoo.sh << 'EOF'
#!/bin/bash
echo "🚀 Démarrage Odoo..."
cd ~/odoo-imprimante3D
docker-compose -f docker-compose.simple.yml up -d

echo "✅ Odoo démarré !"
echo "🌐 URL: http://$(curl -s ifconfig.me):8069"
echo ""
echo "🔑 Mots de passe :"
cat .env | grep PASSWORD
echo ""
echo "📊 Pour voir les logs : docker-compose -f docker-compose.simple.yml logs -f"
EOF

chmod +x start-odoo.sh

echo ""
echo "✅ Installation terminée !"
echo "🔄 Redémarrez pour finaliser Docker : sudo reboot"
echo "📱 Après redémarrage : ./start-odoo.sh"