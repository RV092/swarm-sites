#!/bin/bash
# setup-swarm-site.sh — Configuration complète SWARM SITE

set -e

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║        SWARM SITE — Configuration Automatisée            ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Couleurs
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Fonctions
check_tool() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✅${NC} $1 installé"
        return 0
    else
        echo -e "${RED}❌${NC} $1 non trouvé"
        return 1
    fi
}

check_env() {
    if [ -n "$2" ]; then
        echo -e "${GREEN}✅${NC} $1 configuré"
        return 0
    else
        echo -e "${YELLOW}⚠️${NC}  $1 non configuré"
        return 1
    fi
}

# ============================================
# VÉRIFICATIONS
# ============================================
echo "📊 Vérifications..."
echo ""

echo "🔧 Outils installés :"
check_tool node
check_tool npm
check_tool playwright || echo "   → npm install -g playwright"
check_tool vercel || echo "   → npm install -g vercel"

echo ""
echo "🔑 Configuration APIs :"
check_env "VERCEL" "$(vercel whoami 2>/dev/null)" || echo "   → vercel login"
check_env "APIFY" "$APIFY_API_KEY" || echo "   → Voir CONFIG-API.md"
check_env "UNSPLASH" "$UNSPLASH_ACCESS_KEY" || echo "   → Voir CONFIG-API.md"
check_env "GOOGLE_MAPS" "$GOOGLE_MAPS_API_KEY" || echo "   → Voir CONFIG-API.md"

# ============================================
# CRÉATION FICHIERS TEMPLATE
# ============================================
echo ""
echo "📁 Création fichiers template..."

# Template config openclaw.json
cat > /tmp/swarm-site-env-template.json << 'EOF'
{
  "env": {
    "APIFY_API_KEY": "apify_api_REMPLACER_PAR_VOTRE_CLE",
    "UNSPLASH_ACCESS_KEY": "REMPLACER_PAR_VOTRE_CLE",
    "GOOGLE_MAPS_API_KEY": "AIzaSyREMPLACER_PAR_VOTRE_CLE"
  }
}
EOF
echo -e "${GREEN}✅${NC} Template env créé: /tmp/swarm-site-env-template.json"

# Template fichier URLs manuel
cat > /data/.openclaw/workspace-swarm-site/input/manual-urls.txt << 'EOF'
# URLs manuelles pour SWARM SITE
# Format: une URL par ligne
# Exemples:
# https://business1.com
# https://business2.com
# https://business3.com
EOF
echo -e "${GREEN}✅${NC} Fichier URLs manuel créé"

# ============================================
# TESTS FONCTIONNELS
# ============================================
echo ""
echo "🧪 Tests fonctionnels..."

# Test Playwright
echo -n "   Screenshot Playwright... "
if npx playwright screenshot https://example.com /tmp/test-swarm-setup.png --full-page 2>/dev/null; then
    echo -e "${GREEN}OK${NC}"
    rm /tmp/test-swarm-setup.png
else
    echo -e "${RED}ÉCHEC${NC}"
fi

# Test Vercel
echo -n "   Connexion Vercel... "
if vercel whoami &>/dev/null; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${YELLOW}PAS CONNECTÉ${NC}"
fi

# ============================================
# RÉSUMÉ
# ============================================
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "📊 RÉSUMÉ CONFIGURATION"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "✅ Prêt à démarrer : $(vercel whoami &>/dev/null && echo 'OUI' || echo 'NON (Vercel login requis)')"
echo ""
echo "📋 Prochaines étapes :"
echo ""
echo "   1️⃣  OBLIGATOIRE : vercel login"
echo "      └─> Pour déployer les sites"
echo ""
echo "   2️⃣  RECOMMANDÉ : Configurer Apify"
echo "      └─> Pour scraping automatisé Google Maps"
echo "      └─> Voir: /workspace-swarm-site/CONFIG-API.md"
echo ""
echo "   3️⃣  BONUS : Configurer Unsplash + Google Maps"
echo "      └─> Pour photos pro + widgets maps"
echo "      └─> Voir: /workspace-swarm-site/CONFIG-API.md"
echo ""
echo "🚀 Quand prêt :"
echo "   Lance SWARM SITE pour wedding venues à Paris, 10 entreprises"
echo ""
echo "═══════════════════════════════════════════════════════════"
