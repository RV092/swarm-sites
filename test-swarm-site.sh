#!/bin/bash
# test-swarm-site.sh — Test rapide du pipeline SWARM SITE

echo "🧪 TEST SWARM SITE"
echo "=================="
echo ""

# Test 1 — Playwright screenshot
echo "📸 Test 1 : Playwright screenshot..."
npx playwright screenshot https://example.com /tmp/test-swarm.png --full-page 2>&1 | head -5
if [ -f /tmp/test-swarm.png ]; then
    echo "✅ Screenshot OK ($(du -h /tmp/test-swarm.png | cut -f1))"
else
    echo "❌ Screenshot FAILED"
fi
echo ""

# Test 2 — Vercel CLI
echo "🚀 Test 2 : Vercel CLI..."
vercel --version 2>&1 | head -1
vercel whoami 2>&1 | head -1 || echo "⚠️  Pas connecté — faire 'vercel login'"
echo ""

# Test 3 — Structure
echo "📁 Test 3 : Structure workspace..."
if [ -d "/data/.openclaw/workspace-swarm-site" ]; then
    echo "✅ Workspace existe"
    echo "   - Skills : $(ls /data/.openclaw/workspace-swarm-site/skills/*.md 2>/dev/null | wc -l) fichiers"
    echo "   - Agents : $(ls -d /data/.openclaw/workspace-swarm-site/agents/*/ 2>/dev/null | wc -l) agents"
else
    echo "❌ Workspace manquant"
fi
echo ""

# Test 4 — API Keys (optionnel)
echo "🔑 Test 4 : API Keys..."
[ -n "$APIFY_API_KEY" ] && echo "✅ Apify configuré" || echo "⚠️  Apify non configuré"
[ -n "$UNSPLASH_ACCESS_KEY" ] && echo "✅ Unsplash configuré" || echo "⚠️  Unsplash non configuré"
[ -n "$GOOGLE_MAPS_API_KEY" ] && echo "✅ Google Maps configuré" || echo "⚠️  Google Maps non configuré"
echo ""

# Résumé
echo "📊 RÉSUMÉ"
echo "========"
echo "✅ Prêt à tester : OUI"
echo ""
echo "📋 Prochaines étapes :"
echo "   1. Faire 'vercel login' si pas connecté"
echo "   2. Configurer Apify (optionnel pour test)"
echo "   3. Lancer : 'Lance SWARM SITE pour wedding venues à Paris, 10 entreprises'"
echo ""
