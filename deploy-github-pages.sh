#!/bin/bash
# deploy-github-pages.sh — Déploiement SWARM SITE sur GitHub Pages (GRATUIT)

set -e

# ⚠️ CONFIGURATION
REPO_DIR="/data/swarm-sites"
OUTPUT_DIR="/data/.openclaw/workspace-swarm-site/output"
SCRIPTS_DIR="/data/.openclaw/workspace-swarm-site/scripts"
GITHUB_USER="RV092"  # ⚠️ REMPLACER par ton username

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║     SWARM SITE — Déploiement GitHub Pages (GRATUIT)      ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Vérifications
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "❌ Aucun site généré dans $OUTPUT_DIR"
    echo "   Lance d'abord : Lance SWARM SITE pour [TYPE] à [VILLE], [N]"
    exit 1
fi

SITES_COUNT=$(ls -d $OUTPUT_DIR/*/ 2>/dev/null | wc -l)
if [ "$SITES_COUNT" -eq 0 ]; then
    echo "❌ Aucun site trouvé dans output/"
    echo "   Lance d'abord le pipeline SWARM SITE"
    exit 1
fi

echo "📊 $SITES_COUNT sites à déployer"
echo ""

# Créer repo si n'existe pas
if [ ! -d "$REPO_DIR" ]; then
    echo "📦 Création du repository..."
    mkdir -p $REPO_DIR
    cd $REPO_DIR
    git init
    git remote add origin https://github.com/$GITHUB_USER/swarm-sites.git
    echo "# SWARM SITE — Maquettes PSYKO CORP" > README.md
    git add README.md
    git commit -m "Initial commit"
    git branch -M main
    git push -u origin main
else
    cd $REPO_DIR
fi

# 1. Copier les sites générés
echo "📦 Copie des sites..."
cp -r $OUTPUT_DIR/* .

# 2. Générer l'index
echo "📝 Génération index..."
python3 $SCRIPTS_DIR/generate-index.py

# 3. Git status
echo ""
echo "📊 Changements :"
git status --short

# 4. Commit
echo ""
git add .
git commit -m "Ajout $SITES_COUNT sites - $(date +%Y-%m-%d-%H:%M)"

# 5. Push
echo "🚀 Push vers GitHub..."
git push origin main

# 6. Attendre déploiement
echo ""
echo "⏳ GitHub Pages déploie en 1-2 minutes..."
echo ""
echo "✅ DÉPLOYÉ !"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 URLS DISPONIBLES :"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🏠 INDEX :"
echo "   https://$GITHUB_USER.github.io/swarm-sites/"
echo ""
echo "📊 SITES ($SITES_COUNT) :"
for folder in $OUTPUT_DIR/*/; do
    name=$(basename $folder)
    echo "   https://$GITHUB_USER.github.io/swarm-sites/$name/"
done
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 7. Générer rapport
DEPLOY_LOG="/data/.openclaw/workspace-swarm-site/deployments/deploy-$(date +%Y%m%d-%H%M%S).md"
mkdir -p $(dirname $DEPLOY_LOG)

cat > $DEPLOY_LOG << EOF
# Déploiement GitHub Pages — $(date +%Y-%m-%d\ %H:%M)

**Sites déployés :** $SITES_COUNT
**URL Index :** https://$GITHUB_USER.github.io/swarm-sites/

## Sites

EOF

for folder in $OUTPUT_DIR/*/; do
    name=$(basename $folder)
    echo "- [$name](https://$GITHUB_USER.github.io/swarm-sites/$name/)" >> $DEPLOY_LOG
done

echo ""
echo "📄 Rapport sauvegardé : $DEPLOY_LOG"
