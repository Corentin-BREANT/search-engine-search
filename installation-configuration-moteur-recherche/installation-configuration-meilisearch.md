Installation et configuration de MeiliSearch
============================================

## pré-requis avant installation
* apt update *(Vérification si les paquets déjà installé sont à jours)*
* apt install curl -y *(Installation de cURL, permettant l'installations de paquet via un lien hypertexte)*

## Installation de MeiliSearch
* curl -L https://install.meilisearch.com | sh ./meilisearch *(Installation de MeiliSearch via un lien hypertexte)*
* mv ./meilisearch /usr/bin/ *(Déplacement des paquets de MeiliSearch dans bin)*

## Configuration de MeiliSearch
cat << EOF > /etc/sytemd/system/meilisearch.service
> [Unit]
> 
> Description=MeiliSearch
> 
> After=sytemd-user-sessions.service
> 
> [Service]
> 
> Type=simple
> 
> ExecStart=/usr/bin/meilisearch --http-addr 127.0.0.1:7700 --env production --master -key R0u3nR00T
>
> [Install]
> 
> WantedBy=default.target
> 
> EOF

## Vérification du fonctionnement de MeiliSearch
* systemctl enable meilisearch *(Activation de MeiliSearch)* 
* systemctl start meilisearch *(Démarrage de MeiliSearch)*
* systemctl status meilisearch *(Vérification du status de MeiliSearch)*


## Indexation 
###Configuration pré-requis avant indexation

Avant de lancer l'indexation nous devons créer un fichier de configuration en voici un exemple:
```
{
  "index_uid": "docs",
  "start_urls": ["https://www.example.com/doc/"],
  "sitemap_urls": ["https://www.example.com/sitemap.xml"],
  "stop_urls": [],
  "selectors": {
    "lvl0": {
      "selector": ".docs-lvl0",
      "global": true,
      "default_value": "Documentation"
    },
    "lvl1": {
      "selector": ".docs-lvl1",
      "global": true,
      "default_value": "Chapter"
    },
    "lvl2": ".docs-content .docs-lvl2",
    "lvl3": ".docs-content .docs-lvl3",
    "lvl4": ".docs-content .docs-lvl4",
    "lvl5": ".docs-content .docs-lvl5",
    "lvl6": ".docs-content .docs-lvl6",
    "text": ".docs-content p, .docs-content li"
  }
}
```

Une fois ceci fait nous allons lancer la récupération de données, ce qui s'appel du **"web scrapping"**
```
pipenv install
pipenv run ./docs_scraper <chemin-vers-votre-fichier-config> 
```
* <chemin-vers-votre-fichier-config> devra être remplacer par, comme son nom l'indique, le chemin vers le fichiers config que vous aurez crée plus tôt
