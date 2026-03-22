# Skill 2 — Website Screenshot & Qualifier

**Objectif :** Prendre des screenshots des sites et évaluer visuellement s'ils méritent un redesign

**Outil :** Playwright (gratuit)

---

## 🎯 Ce que ça fait

1. Prend un screenshot full-page de chaque site
2. Analyse visuellement le design
3. Scoring basé sur critères de qualité
4. Filtre les sites qui valent la peine d'être refaits

---

## 📥 Entrées

| Paramètre | Type |
|-----------|------|
| **Liste d'URLs** | Array de strings |
| **Critères** | Objet de scoring |

---

## 📤 Sorties

```json
{
  "qualified": [
    {
      "url": "https://oldsite.com",
      "screenshot": "screenshots/oldsite.png",
      "score": 2.5,
      "issues": ["outdated design", "table layout", "poor typography"],
      "recommend": true
    }
  ],
  "rejected": [
    {
      "url": "https://modernsite.com",
      "score": 8.5,
      "issues": [],
      "recommend": false,
      "reason": "Already modern design"
    }
  ]
}
```

---

## 🔧 Installation Playwright

```bash
# Install
npm install playwright

# Install browsers
npx playwright install chromium
```

---

## 🛠️ Script de Screenshot

```javascript
// screenshot.js
const { chromium } = require('playwright');
const fs = require('fs');

async function takeScreenshot(url, outputPath) {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  
  await page.goto(url, { waitUntil: 'networkidle' });
  await page.screenshot({ 
    path: outputPath, 
    fullPage: true 
  });
  
  await browser.close();
  return outputPath;
}

module.exports = { takeScreenshot };
```

---

## 📊 Critères de Qualification

### Score = Moyenne de ces critères (0-10)

| Critère | Poids | Signes négatifs |
|---------|-------|-----------------|
| **Modernité design** | 25% | Table layouts, gradients 2000s |
| **Typographie** | 20% | Times New Roman, fonts plates |
| **Layout** | 20% | Encombré, non responsive |
| **Couleurs** | 15% | Contrastes faibles, couleurs datées |
| **UX** | 20% | Navigation confuse, CTA absents |

### Seuils de Qualification

| Score | Recommandation | Action |
|-------|----------------|--------|
| **0-3** | 🔴 Très mauvais | ✅ Redesign OBLIGATOIRE |
| **3-5** | 🟡 Moyen | ✅ Redesign recommandé |
| **5-7** | 🟢 Correct | 🔶 Optionnel |
| **7-10** | ✅ Bon | ❌ Pas de redesign |

---

## 🎯 Prompt d'Analyse Visuelle

```
Analyse ce screenshot de site web et donne un score de 0 à 10 basé sur :

1. MODERNITÉ (0-10)
   - Le design semble-t-il des années 2000/2010 ?
   - Y a-t-il des table layouts ?
   - Les gradients sont-ils datés ?

2. TYPOGRAPHIE (0-10)
   - La police est-elle professionnelle ?
   - Y a-t-il une hiérarchie visuelle ?

3. LAYOUT (0-10)
   - Le layout est-il encombré ?
   - Est-ce responsive ?
   - Y a-t-il trop d'éléments ?

4. COULEURS (0-10)
   - Les couleurs sont-elles cohérentes ?
   - Les contrastes sont-ils bons ?

5. UX (0-10)
   - La navigation est-elle claire ?
   - Y a-t-il des CTA visibles ?
   - L'info importante est-elle accessible ?

SCORE FINAL = Moyenne des 5 critères

RECOMMANDATION :
- Score < 5 : "Redesign recommandé"
- Score ≥ 5 : "Site acceptable"

ISSUES : Liste des problèmes identifiés
```

---

## 🛠️ Commande Agent

```
Pour chaque URL dans la liste :
1. Prendre screenshot full-page
2. Analyser visuellement avec LLM
3. Scorer de 0 à 10
4. Si score < 5 → Ajouter à la liste "à refaire"
5. Sinon → Ajouter à la liste "rejeté"
```

---

## 💰 Coûts

| Élément | Coût |
|---------|------|
| Playwright | Gratuit |
| Screenshot storage | ~0.50€/1000 |
| LLM analyse | ~0.01€/site |

**Total :** ~0.02€/site

---

## 🎯 Exemple d'Usage

**Utilisateur :** "Qualifie les 35 sites trouvés"

**Agent :**
```
📸 Prise de screenshots en cours...
   [████████████████████] 35/35

🔍 Analyse visuelle en cours...
   [████████████████████] 35/35

📊 RÉSULTATS :
✅ 18 sites à redesigner (score < 5)
❌ 17 sites rejetés (score ≥ 5)

Top 5 pires sites :
1. oldsalon.com — Score 1.5 (table layout, daté)
2. beauty2000.com — Score 2.0 (typographie pauvre)
3. nails-old.com — Score 2.3 (layout encombré)
...

Veux-tu que je passe à l'étape 3 (redesign) ?
```

---

## ⚠️ Points d'Attention

- **Sites lents** : Timeout possible, augmenter waitUntil
- **Sites dynamiques** : Attendre le chargement JS
- **Sites protégés** : Peut échouer sur certains
- **Volume** : Paralléliser pour accélérer

---

*Skill Site Qualifier — Beautiful Websites Toolkit*
