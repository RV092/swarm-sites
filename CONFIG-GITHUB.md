# SWARM SITE — Configuration GitHub Pages (100% GRATUIT)

**Avantage :** Zéro coût, URLs live, HTTPS automatique

---

## 🎯 Principe

GitHub Pages héberge gratuitement vos sites statiques avec :
- ✅ URLs publiques (`username.github.io/repo`)
- ✅ HTTPS automatique
- ✅ Déploiement via Git
- ✅ 100GB bandwidth/mois (gratuit)

---

## 📦 Setup Initial

### 1. Créer un Repository GitHub

```bash
# Via GitHub CLI (si installé)
gh repo create swarm-sites --public --clone

# Ou manuellement sur https://github.com/new
# Nom : swarm-sites
# Public (obligatoire pour GitHub Pages gratuit)
```

### 2. Structure du Repo

```
swarm-sites/
├── index.html              # Page d'accueil (liste sites)
├── business-1/
│   └── index.html          # Site business 1
├── business-2/
│   └── index.html          # Site business 2
└── ...
```

### 3. Activer GitHub Pages

1. Aller dans **Settings** → **Pages**
2. Source : **Deploy from a branch**
3. Branch : **main** / **root**
4. Sauvegarder

**URL générée :** `https://[username].github.io/swarm-sites/`

---

## 🚀 Déploiement Automatisé

### Script Déploiement

```bash
#!/bin/bash
# deploy-github-pages.sh

REPO_DIR="/data/swarm-sites"
OUTPUT_DIR="/data/.openclaw/workspace-swarm-site/output"
GITHUB_USER="psykocorp"  # Remplacer par ton username

# 1. Copier les sites générés
echo "📦 Copie des sites..."
cp -r $OUTPUT_DIR/* $REPO_DIR/

# 2. Mettre à jour l'index
echo "📝 Mise à jour index..."
cd $REPO_DIR
python3 /data/.openclaw/workspace-swarm-site/scripts/generate-index.py

# 3. Commit & Push
echo "🚀 Déploiement GitHub..."
git add .
git commit -m "Add $(ls -d */ | wc -l) sites - $(date +%Y-%m-%d)"
git push origin main

echo "✅ Déployé !"
echo "URL: https://$GITHUB_USER.github.io/swarm-sites/"
```

---

## 📄 Script Génération Index

```python
# generate-index.py
import os
import glob
from datetime import datetime

def generate_index():
    sites = []
    
    for folder in glob.glob("*/"):
        if folder == "assets/":
            continue
            
        site_name = folder.strip("/")
        index_file = folder + "index.html"
        
        # Lire le titre du site
        title = site_name.replace("-", " ").title()
        if os.path.exists(index_file):
            with open(index_file, 'r') as f:
                content = f.read()
                # Extraire le titre
                if '<title>' in content:
                    title = content.split('<title>')[1].split('</title>')[0]
        
        sites.append({
            'name': title,
            'url': f"/{site_name}/",
            'folder': site_name
        })
    
    # Générer HTML
    html = f"""<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SWARM SITE — Maquettes PSYKO CORP</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen">
    <div class="max-w-6xl mx-auto px-6 py-12">
        <div class="text-center mb-12">
            <h1 class="text-4xl font-bold text-gray-900 mb-4">
                🎨 SWARM SITE
            </h1>
            <p class="text-xl text-gray-600">
                Maquettes web générées par PSYKO CORP
            </p>
            <p class="text-sm text-gray-500 mt-2">
                {len(sites)} sites disponibles — Mis à jour le {datetime.now().strftime("%d/%m/%Y")}
            </p>
        </div>
        
        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {"".join([f'''
            <a href="{site['url']}" class="bg-white rounded-xl shadow-sm hover:shadow-md transition p-6">
                <div class="flex items-center justify-between mb-2">
                    <h3 class="font-semibold text-gray-900">{site['name']}</h3>
                    <span class="text-sm text-gray-400">→</span>
                </div>
                <p class="text-sm text-gray-500">{site['folder']}</p>
            </a>
            ''' for site in sites])}
        </div>
        
        <div class="text-center mt-12 text-gray-500 text-sm">
            <p>Généré automatiquement par SWARM SITE — PSYKO CORP</p>
        </div>
    </div>
</body>
</html>
"""
    
    with open("index.html", 'w') as f:
        f.write(html)
    
    print(f"✅ Index généré avec {len(sites)} sites")

if __name__ == "__main__":
    generate_index()
```

---

## 🔄 Workflow SWARM SITE + GitHub Pages

```
1. GÉNÉRATION
   - Scout IA → Scraping entreprises
   - Audit IA → Qualification sites
   - Design IA → Génération HTML
        ↓
2. DÉPLOIEMENT
   - Copier HTML vers repo GitHub
   - Générer index automatique
   - Commit + Push
        ↓
3. PUBLICATION
   - GitHub Pages détecte le push
   - Déploie automatiquement
   - URLs live en ~1-2 min
        ↓
4. OUTREACH
   - URLs disponibles :
     https://[username].github.io/swarm-sites/business-1/
     https://[username].github.io/swarm-sites/business-2/
```

---

## 💰 Coûts

| Élément | Coût |
|---------|------|
| **GitHub Account** | Gratuit |
| **GitHub Pages** | Gratuit |
| **Repository** | Gratuit (public) |
| **Bandwidth** | 100GB/mois gratuit |
| **HTTPS** | Gratuit |
| **TOTAL** | **0€** |

---

## 📊 URLs Générées

| Site | URL |
|------|-----|
| **Index** | `https://[user].github.io/swarm-sites/` |
| **Business 1** | `https://[user].github.io/swarm-sites/luxe-nails/` |
| **Business 2** | `https://[user].github.io/swarm-sites/wedding-venue/` |
| **Business N** | `https://[user].github.io/swarm-sites/[business-name]/` |

---

## ⚡ Avantages vs Vercel

| Critère | GitHub Pages | Vercel |
|---------|--------------|--------|
| **Coût** | ✅ 100% gratuit | ✅ Gratuit |
| **Setup** | ✅ Git push | ⚠️ CLI login |
| **URLs** | ⚠️ `.github.io` | ✅ `.vercel.app` |
| **Vitesse** | ✅ Rapide | ✅ Très rapide |
| **CDN** | ✅ Oui | ✅ Oui |
| **Compte requis** | ✅ Déjà existant | ⚠️ Nouveau |

---

## 🎯 Commande de Lancement

```bash
# 1. Setup repo (1x)
cd /data
git clone https://github.com/[username]/swarm-sites.git

# 2. Générer sites
# (dans OpenClaw)
Lance SWARM SITE pour wedding venues à Paris, 50 entreprises

# 3. Déployer
cd /data/.openclaw/workspace-swarm-site
./deploy-github-pages.sh
```

---

## 🔧 Alternative — VPS Hostinger

Si tu préfères héberger sur ton VPS (déjà payé) :

```bash
# Config Nginx
sudo nano /etc/nginx/sites-available/swarm-sites

# Contenu
server {
    listen 80;
    server_name sites.psykocorp.com;  # Ou IP
    
    root /var/www/swarm-sites;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
}

# Activer
sudo ln -s /etc/nginx/sites-available/swarm-sites /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

# Déploiement
cp -r /workspace-swarm-site/output/* /var/www/swarm-sites/
```

**URL :** `http://[IP_VPS]/business-1/` ou `http://sites.psykocorp.com/`

---

## 📋 Checklist Setup GitHub Pages

- [ ] Créer repo `swarm-sites` sur GitHub
- [ ] Cloner en local : `git clone ...`
- [ ] Activer GitHub Pages (Settings → Pages)
- [ ] Copier `deploy-github-pages.sh` dans workspace
- [ ] Copier `generate-index.py` dans scripts/
- [ ] Lancer premier déploiement test
- [ ] Vérifier URL : `https://[user].github.io/swarm-sites/`

---

*SWARM SITE — Solution 100% Gratuite avec GitHub Pages*
