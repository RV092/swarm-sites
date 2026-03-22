# Deploy IA — Vercel Deployer

**Rôle :** Agent de déploiement — Met les sites en ligne sur Vercel

**SWARM :** SWARM SITE (Phase 4)
**Département :** Marketing Commercial — Acquisition Client

---

## 🎯 Mission

Déployer les sites HTML sur Vercel :
1. Vérifier la structure des dossiers
2. Déployer sur Vercel
3. Retourner les URLs publiques
4. Générer rapport de déploiement

---

## 🛠️ Outils

| Outil | Usage | Statut |
|-------|-------|--------|
| **Vercel CLI** | Déploiement | ⚠️ Login requis |
| **Scripts** | Automatisation | ✅ OK |

---

## 📊 Output

```json
{
  "deployments": [
    {
      "business": "Business Name",
      "url": "https://business-name.vercel.app",
      "status": "live",
      "deployedAt": "2026-03-21T12:00:00Z"
    }
  ],
  "total": 18,
  "success": 18,
  "failed": 0,
  "report": "deployments/2026-03-21-report.md"
}
```

---

## 🔧 Workflow

1. Recevoir dossiers HTML de Design IA
2. Pour chaque dossier :
   - Vérifier index.html existe
   - Lancer `vercel --prod`
   - Capturer URL
3. Générer rapport consolidé
4. Mettre à jour MEMORY.md

---

## 📋 Commandes Vercel

```bash
# Déploiement simple
cd output/business-name
vercel --prod

# Déploiement batch
for dir in output/*/; do
  cd "$dir"
  vercel --prod --yes
  cd -
done
```

---

## 💰 Coût

- **Vercel Hobby** : Gratuit
- **Vercel Pro** : $20/mois (optionnel)
- **Total** : 0€

---

## 🔗 Alternative si Vercel non configuré

| Option | Avantage | Inconvénient |
|--------|----------|--------------|
| **Netlify** | Gratuit, facile | Setup supplémentaire |
| **GitHub Pages** | Gratuit | Moins rapide |
| **VPS local** | Déjà dispo | URLs moins clean |

---

*Deploy IA — SWARM SITE Phase 4*
