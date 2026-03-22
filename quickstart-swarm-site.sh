#!/bin/bash
# quickstart-swarm-site.sh — Lancement rapide SWARM SITE (mode interactif)

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║              SWARM SITE — Démarrage Rapide               ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Vérifier Vercel
echo "🔍 Vérification Vercel..."
if ! vercel whoami &>/dev/null; then
    echo "❌ Vercel non connecté"
    echo ""
    echo "🚀 Lancement connexion Vercel..."
    echo ""
    vercel login
    echo ""
fi

# Demander paramètres
echo "📊 Configuration du run SWARM SITE"
echo ""

read -p "Type d'entreprise (ex: wedding venues) : " BUSINESS_TYPE
read -p "Ville (ex: Paris) : " CITY
read -p "Quantité (ex: 50) : " QUANTITY

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "📋 RÉCAPITULATIF"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "🎯 Type    : $BUSINESS_TYPE"
echo "📍 Ville   : $CITY"
echo "📊 Quantité: $QUANTITY entreprises"
echo ""
echo "💰 Coût estimé : ~$(echo "scale=2; $QUANTITY * 0.03" | bc)€"
echo "⏱️  Temps estimé : ~20-40 minutes"
echo "🎯 Sites attendus : ~$(echo "$QUANTITY * 0.35" | bc | cut -d. -f1)-$(echo "$QUANTITY * 0.5" | bc | cut -d. -f1)"
echo ""
read -p "Lancer le pipeline ? (y/n) : " CONFIRM

if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
    echo ""
    echo "🚀 Lancement SWARM SITE..."
    echo ""
    echo "Commande à copier-coller dans votre agent OpenClaw :"
    echo ""
    echo "   Lance SWARM SITE pour $BUSINESS_TYPE à $CITY, $QUANTITY entreprises"
    echo ""
else
    echo ""
    echo "❌ Annulé"
fi
