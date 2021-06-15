Installation et Configuration de ElasticSearch
==============================================

## Pré-requis avant l'installation
* mkdir -p /usr/lib/jvm && sudo wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz && sudo tar xvf openjdk-11.0.2_linux-x64_bin.tar.gz --directory /usr/lib/jvm/ && sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.2/bin/java 1 && sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-11.0.2/bin/javac 1
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - *(transfert de données avec URL d'Elasticsearch)*
* echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list *(ajout de la liste des sources Elastic au répertoire sources.list.d)*
* apt update *(Vérification de si les paquets déjà installé sont à jour)*
* (facultatif) apt upgrade *(Mise à jour des paquets)*

## Installation de ElasticSearch

* apt install elasticsearch *(Installation des paquets de ElasticSearch)*

## Configuration de ElasticSearch

* nano /etc/elasticsearch/elasticsearch.yml *(Ouvre le fichier de configuration de elasticsearch)

Modifier le fichier pour qu'il ressemble au paramètre ci-dessous:
#### /etc/elasticsearch/elasticsearch.yml
``` 
. . .
# ---------------------------------- Network -----------------------------------
#
# Set the bind address to a specific IP (IPv4 or IPv6):
#
network.host: localhost
. . .
```

## Vérification du fonctionnement de elasticsearch
* systemctl enable elasticsearch *(Activation de ElasticSearch)*
* systemctl start elasticsearch *(Démarrage de ElasticSearch)*
* systemctl status elasticsearch *(Vérification du status de ElasticSearch)*