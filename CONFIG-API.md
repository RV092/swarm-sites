# SWARM SITE — Configuration APIs

## 📋 État Actuel

| API | Usage | Statut | Action Requise |
|-----|-------|--------|----------------|
| **Vercel** | Déploiement sites | ⚠️ CLI installé | `vercel login` |
| **Apify** | Scraping Google Maps | ❌ Non configuré | Créer compte + clé |
| **Unsplash** | Photos stock HD | ❌ Non configuré | Créer compte + clé |
| **Google Maps** | Widgets maps | ❌ Non configuré | Activer API + clé |

---

## 🔧 Configuration Vercel (OBLIGATOIRE)

### Étapes

```bash
# 1. Se connecter (ouvre le navigateur)
vercel login

# 2. Choisir le provider (GitHub, GitLab, Bitbucket, ou email)
# 3. Autoriser l'accès
# 4. Vérifier la connexion
vercel whoami
```

**Note :** Vercel Hobby = Gratuit (100GB bandwidth/mois)

---

## 🔧 Configuration Apify (RECOMMANDÉ)

### 1. Créer un compte Apify

- URL : https://console.apify.com/
- Plan gratuit : 5$/mois de crédits (suffisant pour ~250 entreprises)

### 2. Obtenir la clé API

1. Aller dans **Settings** → **API & Integrations**
2. Cliquer **Create new API token**
3. Copier la clé (format : `apify_api_xxxxx`)

### 3. Ajouter dans OpenClaw

```bash
# Éditer la configuration
nano /data/.openclaw/openclaw.json
```

Ajouter dans `env` :
```json
{
  "env": {
    "APIFY_API_KEY": "apify_api_xxxxx"
  }
}
```

### 4. Recharger OpenClaw

```bash
openclaw gateway restart
```

**Coût estimé :** ~0.20€ pour 50 entreprises

---

## 🔧 Configuration Unsplash (OPTIONNEL)

### 1. Créer un compte développeur

- URL : https://unsplash.com/developers
- Plan gratuit : 50 requêtes/heure

### 2. Créer une application

1. Cliquer **New Application**
2. Nommer "SWARM SITE"
3. Accepter les termes
4. Copier **Access Key**

### 3. Ajouter dans OpenClaw

```json
{
  "env": {
    "UNSPLASH_ACCESS_KEY": "xxxxx"
  }
}
```

**Note :** Sans Unsplash, les sites utiliseront des placeholders

---

## 🔧 Configuration Google Maps (OPTIONNEL)

### 1. Activer l'API

- URL : https://console.cloud.google.com/
- Aller dans **APIs & Services** → **Library**
- Activer **Maps Embed API**

### 2. Créer une clé API

1. **APIs & Services** → **Credentials**
2. **Create Credentials** → **API Key**
3. Restreindre à **Maps Embed API** uniquement

### 3. Ajouter dans OpenClaw

```json
{
  "env": {
    "GOOGLE_MAPS_API_KEY": "AIzaSyxxxxx"
  }
}
```

**Note :** Sans Google Maps, l'adresse sera affichée en texte

---

## 📊 Configuration Minimale vs Complète

### ⚡ Configuration Minimale (Démarrage Rapide)

| API | Nécessaire | Pourquoi |
|-----|------------|----------|
| **Vercel** | ✅ OUI | Déploiement obligatoire |
| **Apify** | ❌ NON | Scraping manuel possible |
| **Unsplash** | ❌ NON | Placeholders acceptables |
| **Google Maps** | ❌ NON | Adresse texte suffit |

**Temps setup :** 2 minutes (juste Vercel login)

### 🚀 Configuration Complète (Production)

| API | Nécessaire | Pourquoi |
|-----|------------|----------|
| **Vercel** | ✅ OUI | Déploiement obligatoire |
| **Apify** | ✅ OUI | Scraping automatisé |
| **Unsplash** | ✅ OUI | Photos professionnelles |
| **Google Maps** | ✅ OUI | UX professionnelle |

**Temps setup :** 15 minutes

---

## 🎯 Priorité de Configuration

1. **IMMÉDIAT :** Vercel login (obligatoire)
2. **RECOMMANDÉ :** Apify (automatisation scraping)
3. **BONUS :** Unsplash + Google Maps (qualité sites)

---

## 💡 Fallbacks si pas de configuration

### Sans Apify → Scraping Manuel

1. Aller sur Google Maps
2. Rechercher "wedding venues Paris"
3. Copier les URLs dans un fichier
4. Agent traite la liste

### Sans Unsplash → Placeholders

```html
<!-- Remplacer photos par -->
<img src="https://via.placeholder.com/800x600?text=Photo" />
```

### Sans Google Maps → Adresse Texte

```html
<!-- Afficher adresse en texte -->
<p>📍 123 Rue de la Paix, Paris 75001</p>
<a href="https://maps.google.com/?q=adresse">Voir sur Google Maps</a>
```

---

*Configuration SWARM SITE — 2026-03-21*
