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