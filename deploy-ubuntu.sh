#!/bin/bash
# 🚀 Script de déploiement Odoo sur Ubuntu 22.04 - Oracle Cloud

echo "🌟 Déploiement Odoo Imprimante 3D sur Ubuntu"
echo "============================================="

# Mise à jour du système
echo "📦 Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

# Installation des outils de base
echo "🔧 Installation des outils..."
sudo apt install -y git curl wget unzip

# Installation Docker
echo "🐳 Installation Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
rm get-docker.sh

# Installation Docker Compose
echo "🔗 Installation Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Configuration firewall Ubuntu
echo "🔥 Configuration firewall..."
sudo ufw allow OpenSSH
sudo ufw allow 8069/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

# Clone du projet
echo "📂 Téléchargement du projet..."
cd /home/ubuntu
git clone https://github.com/D4GNIR/odoo-imprimande3D.git
cd odoo-imprimande3D

# Configuration des variables d'environnement
echo "⚙️ Configuration..."
cat > .env << EOF
# Configuration Odoo pour Ubuntu - Oracle Cloud
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
sudo chown -R ubuntu:ubuntu /home/ubuntu/odoo-imprimande3D

# Création du script de démarrage
cat > start-odoo.sh << 'EOF'
#!/bin/bash
echo "🚀 Démarrage Odoo..."
cd ~/odoo-imprimande3D
docker-compose -f docker-compose.simple.yml up -d

echo "✅ Odoo démarré !"
echo "🌐 URL: http://$(curl -s ifconfig.me):8069"
echo ""
echo "🔑 Mots de passe :"
cat .env | grep PASSWORD
echo ""
echo "📊 Pour voir les logs : docker-compose -f docker-compose.simple.yml logs -f"
echo "🔄 Pour redémarrer : docker-compose -f docker-compose.simple.yml restart"
echo "🛑 Pour arrêter : docker-compose -f docker-compose.simple.yml down"
EOF

chmod +x start-odoo.sh

echo ""
echo "✅ Installation terminée !"
echo "🔄 Redémarrez pour finaliser Docker : sudo reboot"
echo "📱 Après redémarrage : ./start-odoo.sh"
echo "🌐 Votre Odoo sera sur : http://$(curl -s ifconfig.me):8069"