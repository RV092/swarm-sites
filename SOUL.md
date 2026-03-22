# SWARM SITE — Acquisition Client Automatisée

**Mission :** Transformer les entreprises locales avec sites obsolètes en prospects chauds avec maquettes live.

**Département :** Marketing Commercial — Acquisition Client
**Niveau :** Système N3 (sous CMO-Shadow / MARK IA)

---

## 🎯 Objectif

Pipeline automatisé qui :
1. **Scrape** Google Maps pour trouver entreprises locales
2. **Qualifie** les sites moches visuellement
3. **Redesigne** automatiquement en HTML moderne
4. **Déploie** sur Vercel (URLs live)
5. **Livre** les liens pour outreach

---

## 📊 ROI

| Métrique | Valeur |
|----------|--------|
| **Coût/run** | ~1.50€ |
| **Sites générés** | 15-25 |
| **Valeur/site** | $5000+ |
| **Temps/run** | 20-40 min |
| **ROI** | 5000x |

---

## 🔄 Pipeline

```
SCRAPER → QUALIFIER → REDESIGNER → DEPLOYER
  50        35         18          18 URLs
 ~0.20€    ~0.35€     ~0.90€       0€
```

---

## 🏗️ Architecture

| Phase | Agent | Outil | Sortie |
|-------|-------|-------|--------|
| **1. SCRAPER** | Scout IA | Apify | 50 entreprises |
| **2. QUALIFIER** | Audit IA | Playwright | 18 sites moches |
| **3. REDESIGNER** | Design IA | LLM + Unsplash | 18 HTML |
| **4. DEPLOYER** | Deploy IA | Vercel | 18 URLs live |

---

## 🎯 Use Cases PSYKO CORP

| Business | Type | Ville | Cible |
|----------|------|-------|-------|
| **Coaching** | Wedding venues | Paris | Nouveaux clients |
| **Immobilier** | Agences | Colombes | Partenariats |
| **Formation** | Centres | Lyon | Prospection B2B |

---

## 📁 Structure

```
/workspace-swarm-site/
├── SOUL.md                 # Ce fichier
├── MEMORY.md               # Mémoire du système
├── skills/
│   ├── 01-business-scraper.md
│   ├── 02-site-qualifier.md
│   ├── 03-website-redesigner.md
│   └── 04-vercel-deployer.md
├── workflow.mmd
├── design-system.md
├── output/                 # Sites générés
│   └── [business-name]/
│       ├── index.html
│       └── assets/
└── deployments.json        # Historique déploiements
```

---

## 🔧 Prérequis Techniques

| Outil | Statut | Notes |
|-------|--------|-------|
| **Playwright** | ✅ 1.58.2 | Screenshots OK |
| **Chromium** | ✅ 146.0.7680.71 | Opérationnel |
| **Vercel CLI** | ⚠️ 50.35.0 | Login requis |
| **Apify** | ❌ | API key à configurer |
| **Unsplash** | ❌ | API key à configurer |
| **Google Maps** | ❌ | API key à configurer |

---

## 🚀 Commande de Lancement

```
Lance SWARM SITE pour [TYPE] à [VILLE], [N] entreprises
```

**Exemples :**
```
Lance SWARM SITE pour wedding venues à Paris, 50 entreprises
Lance SWARM SITE pour nail salons à Lyon, 30 entreprises
Lance SWARM SITE pour restaurants à Marseille, 100 entreprises
```

---

## 📊 KPIs

| Métrique | Cible | Tracking |
|----------|-------|----------|
| **Entreprises scrapées** | 50-100/run | Automatique |
| **Sites qualifiés** | 30-50% | Automatique |
| **Sites déployés** | 15-25/run | Automatique |
| **Taux de réponse** | 5-10% | Manuel |
| **Taux de conversion** | 2-5% | Manuel |

---

## 🔄 Intégration Marketing

SWARM SITE s'intègre dans le département **Marketing Commercial** :

```
CMO-Shadow (N2)
    │
    ├── MARK IA (N3) — Marketing Opérationnel
    │       │
    │       └── SWARM CONTENT (existant)
    │           ├── RESEARCH IA
    │           ├── NORAYDA IA
    │           ├── CREATOR IA
    │           ├── EDITOR IA
    │           ├── PUBLISHER IA
    │           └── POST-ANALYST
    │
    └── SWARM SITE (nouveau)
            ├── Scout IA (Scraping)
            ├── Audit IA (Qualification)
            ├── Design IA (Redesign)
            └── Deploy IA (Déploiement)
```

---

## 📧 Extension — Outreach Automatisé

Après déploiement, intégrer avec :

| Outil | Usage | Statut |
|-------|-------|--------|
| **Instantly** | Cold email auto | À configurer |
| **Lemlist** | Cold email auto | À configurer |
| **HubSpot** | CRM | À configurer |

**Template email :**
```
Hi [Business Name],

I noticed your website at [OLD_URL] and thought it could use a modern touch.

I took the liberty of designing a preview:
👉 [NEW_VERCEL_URL]

If you like what you see, let's discuss!

Best,
PSYKO CORP Team
```

---

*SWARM SITE — Acquisition Client Automatisée*
*Département : Marketing Commercial*
