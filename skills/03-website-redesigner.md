# Skill 3 — Website Redesigner

**Objectif :** Générer un site moderne en HTML unique à partir d'un site existant

**Outils :** LLM (Claude/GPT) + Unsplash API

---

## 🎯 Ce que ça fait

1. Scrape le contenu du site existant
2. Extrait les infos clés (histoire, services, adresse, contact)
3. Cherche des photos pertinentes sur Unsplash
4. Génère un HTML moderne style $5000+
5. Intègre Google Maps widget
6. Vérifie que toutes les photos chargent

---

## 📥 Entrées

| Paramètre | Source |
|-----------|--------|
| **URL du site** | Skill 2 (qualifiés) |
| **Contenu existant** | Scrape automatique |
| **Photos** | Unsplash API |

---

## 📤 Sorties

```
/workspace/beautiful-websites/output/
├── business-name/
│   ├── index.html        # Site complet
│   ├── assets/
│   │   └── images/       # Photos Unsplash
│   └── metadata.json     # Infos extraites
```

---

## 🔧 Étapes du Processus

### Étape 1 — Scraper le contenu existant

```javascript
// scrape-content.js
const puppeteer = require('puppeteer');

async function scrapeContent(url) {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto(url);
  
  const content = await page.evaluate(() => {
    return {
      title: document.title,
      description: document.querySelector('meta[name="description"]')?.content,
      h1: document.querySelector('h1')?.textContent,
      about: document.querySelector('.about, #about')?.textContent,
      services: Array.from(document.querySelectorAll('.service')).map(s => s.textContent),
      address: document.querySelector('.address, [itemprop="address"]')?.textContent,
      phone: document.querySelector('[href^="tel:"]')?.textContent,
      email: document.querySelector('[href^="mailto:"]')?.textContent,
    };
  });
  
  await browser.close();
  return content;
}
```

### Étape 2 — Chercher photos sur Unsplash

```javascript
// unsplash-search.js
const axios = require('axios');

async function searchPhotos(query, count = 5) {
  const response = await axios.get('https://api.unsplash.com/search/photos', {
    params: { query, per_page: count },
    headers: { Authorization: `Client-ID ${UNSPLASH_KEY}` }
  });
  
  return response.data.results.map(photo => ({
    url: photo.urls.regular,
    alt: photo.alt_description,
    credit: photo.user.name
  }));
}

// Usage
const photos = await searchPhotos('nail salon luxury', 5);
```

### Étape 3 — Vérifier que les photos chargent

```javascript
// verify-photos.js
async function verifyPhotos(photoUrls) {
  const valid = [];
  
  for (const url of photoUrls) {
    try {
      const response = await fetch(url, { method: 'HEAD' });
      if (response.ok) valid.push(url);
    } catch (e) {
      console.log(`Photo failed: ${url}`);
    }
  }
  
  return valid;
}
```

### Étape 4 — Générer le HTML

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{BUSINESS_NAME}} | Premium Services</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        * { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-white">
    <!-- Navigation -->
    <nav class="fixed w-full bg-white/80 backdrop-blur-md z-50 border-b border-gray-100">
        <div class="max-w-6xl mx-auto px-6 py-4">
            <div class="flex justify-between items-center">
                <div class="text-xl font-semibold text-gray-900">{{BUSINESS_NAME}}</div>
                <div class="hidden md:flex space-x-8">
                    <a href="#services" class="text-gray-600 hover:text-gray-900 transition">Services</a>
                    <a href="#about" class="text-gray-600 hover:text-gray-900 transition">About</a>
                    <a href="#contact" class="text-gray-600 hover:text-gray-900 transition">Contact</a>
                </div>
                <a href="#contact" class="bg-gray-900 text-white px-6 py-2 rounded-full hover:bg-gray-800 transition">
                    Book Now
                </a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="pt-32 pb-20 px-6">
        <div class="max-w-6xl mx-auto">
            <div class="grid md:grid-cols-2 gap-12 items-center">
                <div>
                    <h1 class="text-5xl md:text-6xl font-bold text-gray-900 leading-tight mb-6">
                        Premium Beauty Services in {{CITY}}
                    </h1>
                    <p class="text-xl text-gray-600 mb-8">
                        {{TAGLINE}}
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4">
                        <a href="#contact" class="bg-gray-900 text-white px-8 py-4 rounded-full hover:bg-gray-800 transition text-center">
                            Book Appointment
                        </a>
                        <a href="#services" class="border border-gray-300 text-gray-700 px-8 py-4 rounded-full hover:border-gray-900 transition text-center">
                            Our Services
                        </a>
                    </div>
                </div>
                <div class="relative">
                    <img src="{{HERO_IMAGE}}" alt="Premium services" class="rounded-2xl shadow-2xl">
                    <div class="absolute -bottom-4 -left-4 bg-white p-4 rounded-xl shadow-lg">
                        <div class="flex items-center gap-2">
                            <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                            <span class="text-sm font-medium">Open Today</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="py-20 bg-gray-50 px-6">
        <div class="max-w-6xl mx-auto">
            <div class="text-center mb-16">
                <h2 class="text-4xl font-bold text-gray-900 mb-4">Our Services</h2>
                <p class="text-gray-600 max-w-2xl mx-auto">Premium treatments tailored to your needs</p>
            </div>
            <div class="grid md:grid-cols-3 gap-8">
                {{SERVICES_CARDS}}
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-20 px-6">
        <div class="max-w-6xl mx-auto">
            <div class="grid md:grid-cols-2 gap-12 items-center">
                <img src="{{ABOUT_IMAGE}}" alt="Our story" class="rounded-2xl">
                <div>
                    <h2 class="text-4xl font-bold text-gray-900 mb-6">Our Story</h2>
                    <p class="text-gray-600 text-lg leading-relaxed mb-6">
                        {{ABOUT_TEXT}}
                    </p>
                    <div class="grid grid-cols-2 gap-6">
                        <div>
                            <div class="text-3xl font-bold text-gray-900">{{YEARS_EXPERIENCE}}+</div>
                            <div class="text-gray-600">Years Experience</div>
                        </div>
                        <div>
                            <div class="text-3xl font-bold text-gray-900">{{CUSTOMERS}}+</div>
                            <div class="text-gray-600">Happy Customers</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-20 bg-gray-900 text-white px-6">
        <div class="max-w-6xl mx-auto">
            <div class="grid md:grid-cols-2 gap-12">
                <div>
                    <h2 class="text-4xl font-bold mb-6">Visit Us</h2>
                    <div class="space-y-4 mb-8">
                        <div class="flex items-center gap-4">
                            <i data-lucide="map-pin" class="w-6 h-6"></i>
                            <span>{{ADDRESS}}</span>
                        </div>
                        <div class="flex items-center gap-4">
                            <i data-lucide="phone" class="w-6 h-6"></i>
                            <span>{{PHONE}}</span>
                        </div>
                        <div class="flex items-center gap-4">
                            <i data-lucide="mail" class="w-6 h-6"></i>
                            <span>{{EMAIL}}</span>
                        </div>
                    </div>
                </div>
                <div class="rounded-2xl overflow-hidden h-64">
                    <!-- Google Maps Embed -->
                    <iframe 
                        src="https://www.google.com/maps/embed/v1/place?key={{GOOGLE_MAPS_KEY}}&q={{ADDRESS_ENCODED}}"
                        width="100%" 
                        height="100%" 
                        style="border:0;" 
                        allowfullscreen=""
                        loading="lazy">
                    </iframe>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="py-8 bg-gray-950 text-gray-400 px-6">
        <div class="max-w-6xl mx-auto text-center">
            <p>&copy; 2026 {{BUSINESS_NAME}}. All rights reserved.</p>
        </div>
    </footer>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>
```

---

## 🎨 Design System Intégré

### Inspiré de "Taste" par Leon

| Élément | Style |
|---------|-------|
| **Fonts** | Inter (clean, moderne) |
| **Colors** | Noir/Blanc/Gris neutres |
| **Radius** | 1rem (arrondi moderne) |
| **Shadows** | Subtiles, 2 layers max |
| **Spacing** | 6rem sections, 1.5rem padding |
| **CTA** | Boutons arrondis, hover smooth |

---

## 📊 Build Log — Éviter Répétitions

```json
{
  "builds": [
    {
      "business": "Luxe Nails",
      "date": "2026-03-21",
      "design_id": "hero-left-1",
      "photos": ["salon-1", "beauty-1"],
      "avoid": ["hero-left-1", "services-grid-3"]
    }
  ]
}
```

Chaque nouveau build vérifie ce log pour éviter les mêmes combinaisons.

---

## 💰 Coûts

| Élément | Coût |
|---------|------|
| Scrape contenu | ~0€ |
| Unsplash API | Gratuit (50 req/h) |
| LLM génération | ~0.05€/site |
| **Total** | **~0.05€/site** |

---

## 🎯 Exemple d'Usage

**Utilisateur :** "Redesign les 18 sites qualifiés"

**Agent :**
```
🎨 Redesign en cours...
   [██████████] 18/18

✅ Sites générés :
1. luxenails-sydney/index.html
2. beauty-bar/index.html
3. nails-expert/index.html
...

📊 Stats :
- Photos vérifiées : 90/90
- Google Maps intégrés : 18/18
- Build time : 12 min

Veux-tu que je déploie sur Vercel ? (étape 4)
```

---

*Skill Website Redesigner — Beautiful Websites Toolkit*
