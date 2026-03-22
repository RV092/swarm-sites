#!/usr/bin/env python3
# generate-index.py — Génère index.html pour GitHub Pages

import os
import glob
from datetime import datetime

def generate_index():
    sites = []
    
    for folder in glob.glob("*/"):
        if folder in ["assets/", "scripts/"]:
            continue
            
        site_name = folder.strip("/")
        index_file = folder + "index.html"
        
        # Lire le titre du site
        title = site_name.replace("-", " ").title()
        if os.path.exists(index_file):
            with open(index_file, 'r', encoding='utf-8') as f:
                content = f.read()
                # Extraire le titre
                if '<title>' in content:
                    title = content.split('<title>')[1].split('</title>')[0].strip()
        
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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>* {{ font-family: 'Inter', sans-serif; }}</style>
</head>
<body class="bg-gray-50 min-h-screen">
    <div class="max-w-6xl mx-auto px-6 py-12">
        <div class="text-center mb-12">
            <h1 class="text-4xl font-bold text-gray-900 mb-4">
                🎨 SWARM SITE
            </h1>
            <p class="text-xl text-gray-600 mb-2">
                Maquettes web générées automatiquement
            </p>
            <p class="text-sm text-gray-500">
                {len(sites)} sites disponibles — Mis à jour le {datetime.now().strftime("%d/%m/%Y à %H:%M")}
            </p>
        </div>
        
        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {"".join([f'''
            <a href="{site['url']}" class="bg-white rounded-xl shadow-sm hover:shadow-lg transition-all duration-200 p-6 group">
                <div class="flex items-center justify-between mb-3">
                    <h3 class="font-semibold text-gray-900 group-hover:text-blue-600 transition">
                        {site['name']}
                    </h3>
                    <span class="text-gray-300 group-hover:text-blue-600 transition">→</span>
                </div>
                <p class="text-sm text-gray-500">{site['folder']}</p>
            </a>
            ''' for site in sites])}
        </div>
        
        <div class="text-center mt-16 pt-8 border-t border-gray-200">
            <p class="text-gray-400 text-sm">
                Généré automatiquement par 
                <span class="font-medium">SWARM SITE</span> — 
                <span class="font-semibold text-gray-600">PSYKO CORP</span>
            </p>
            <p class="text-gray-300 text-xs mt-2">
                Acquisition Client Automatisée • ROI 5000x
            </p>
        </div>
    </div>
</body>
</html>
"""
    
    with open("index.html", 'w', encoding='utf-8') as f:
        f.write(html)
    
    print(f"✅ Index généré avec {len(sites)} sites")
    return len(sites)

if __name__ == "__main__":
    generate_index()
