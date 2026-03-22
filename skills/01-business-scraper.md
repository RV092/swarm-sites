# Skill 1 — Google Maps Business Scraper

**Objectif :** Extraire les entreprises locales depuis Google Maps avec email + website

**Outil :** Apify — Google Maps Email Extractor

---

## 🎯 Ce que ça fait

1. Recherche entreprises sur Google Maps par type + ville
2. Extrait emails, websites, adresses, téléphones
3. Filtre automatiquement les entrées invalides
4. Retourne une liste structurée de leads qualifiés

---

## 📥 Entrées Utilisateur

| Paramètre | Exemple | Obligatoire |
|-----------|---------|-------------|
| **Type entreprise** | "nail salons", "wedding venues" | ✅ |
| **Ville** | "Sydney", "Paris" | ✅ |
| **Quantité** | 50, 100 | ✅ |
| **Filtres** | Website requis, email requis | Optionnel |

---

## 📤 Sorties

```json
{
  "businesses": [
    {
      "name": "Luxe Nails Sydney",
      "email": "contact@luxenails.com",
      "website": "https://luxenails.com",
      "address": "123 George St, Sydney NSW 2000",
      "phone": "+61 2 1234 5678",
      "rating": 4.5,
      "reviews": 127
    }
  ],
  "total": 50,
  "filtered": 35,
  "cost": 0.20
}
```

---

## 🔧 Configuration Apify

### 1. Créer un compte Apify
- https://console.apify.com/
- Plan gratuit : 5$/mois de crédits

### 2. Obtenir l'Actor
- Actor : `compass/google-maps-email-extractor`
- Ou : `lukaskrivka/google-maps-with-contact-details`

### 3. Paramètres de l'Actor

```json
{
  "searchStringsArray": ["nail salons Sydney"],
  "maxCrawledPlaces": 50,
  "maxItems": 50,
  "emails": true,
  "website": true,
  "phone": true
}
```

---

## 🛠️ Commande Agent

```bash
# Lancer le scraping
apify call compass/google-maps-email-extractor \
  --input '{"searchStringsArray": ["nail salons Sydney"], "maxCrawledPlaces": 50}'
```

---

## 📊 Filtrage Automatique

L'agent doit :

1. ✅ Garder les entreprises avec **website + email**
2. ❌ Supprimer les entrées sans website
3. ❌ Supprimer les emails invalides (ex: `info@`, `contact@` génériques)
4. ❌ Supprimer les doublons

---

## 💰 Coûts

| Quantité | Coût estimé |
|----------|-------------|
| 50 entreprises | ~0.20€ |
| 100 entreprises | ~0.40€ |
| 500 entreprises | ~2.00€ |

---

## 🎯 Exemple d'Usage

**Utilisateur :** "Trouve 50 wedding venues à Sydney"

**Agent :**
```
✅ Lancement scraping Google Maps...
📊 50 entreprises trouvées
📧 42 avec email
🌐 38 avec website
✅ 35 leads qualifiés (email + website)
💰 Coût : 0.18€

Veux-tu que je passe à l'étape 2 (qualification visuelle) ?
```

---

## ⚠️ Points d'Attention

- **Rate limiting** : Ne pas scraper trop agressivement
- **Qualité emails** : Certains sont génériques (info@, admin@)
- **Sites temporaires** : Certains websites sont down
- **RGPD** : Respecter les règles locales pour Europe

---

## 🔗 Alternatives

| Outil | Avantages | Inconvénients |
|-------|-----------|---------------|
| **Apify** | Facile, complet | Payant au-delà quota |
| **Bright Data** | Très puissant | Cher |
| **SerpApi** | Bon marché | Moins de données |
| **Custom scraper** | Gratuit | Maintenance |

---

*Skill Business Scraper — Beautiful Websites Toolkit*
