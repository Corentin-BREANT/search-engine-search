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

## Indexation
### pré-requis
Avant de lancer l'indexation de Elasticsearch il faut récupéré les données du sites pour pouvoir l'indexé, pour cela nous faisons du **"web scrapping"**
Pour cela nous installons *Lassie* ainsi que *certifi*, *urllib3* et *PoolManager* comme ceci:
```
import lassie
from elasticsearch import Elasticsearch
import os
import certifi
import urllib3
```
Une fois ceci fait, nous créeons un client
```
http = urllib3.PoolManager(
cert_reqs='CERT_REQUIRED',
ca_certs=certifi.where())
```
Nous crééons ensuite un client pour ElasticSearch
```
es = Elasticsearch([
    'https://{}:{}@{}/'.format(username, password, base_url),
],
verify_certs=True)
```
### Lancement de l'indexation
Via ce programme nous récupérons les documents, nous lançons l'indexation puis interrogeons pour tous les éléments correspondant à l'index :
```
es.indices.refresh(index="test-index")
res = es.search(index="test-index", body={"query": {"match_all": {}}})
print("Got %d Hits:" % res['hits']['total'])
for hit in res['hits']['hits']:
    print(hit["_source"])
```
résultats : 
```
Got 1 Hit:
{'images': [{'src': 'https://i.ytimg.com/vi/xB0E9X6Nmxk/maxresdefault.jpg', 'type': 'og:image'}, {'src': 'https://i.ytimg.com/vi/xB0E9X6Nmxk/maxresdefault.jpg', 'type': 'twitter:image'}, {'src': 'https://s.ytimg.com/yts/img/favicon-vflz7uhzw.ico', 'type': 'favicon'}, {'src': 'https://www.youtube.com/yts/img/favicon_32-vfl8NGn4k.png', 'type': 'favicon'}, {'src': 'https://www.youtube.com/yts/img/favicon_48-vfl1s0rGh.png', 'type': 'favicon'}, {'src': 'https://www.youtube.com/yts/img/favicon_96-vfldSA3ca.png', 'type': 'favicon'}, {'src': 'https://www.youtube.com/yts/img/favicon_144-vflWmzoXw.png', 'type': 'favicon'}], 'videos': [{'src': 'http://www.youtube.com/v/xB0E9X6Nmxk?version=3&autohide=1', 'secure_src': 'https://www.youtube.com/v/xB0E9X6Nmxk?version=3&autohide=1', 'type': 'application/x-shockwave-flash', 'width': 1280, 'height': 720}, {'src': 'https://www.youtube.com/embed/xB0E9X6Nmxk', 'width': 1280, 'height': 720}], 'title': 'Qbox is Hosted Elasticsearch', 'url': 'https://www.youtube.com/watch?v=xB0E9X6Nmxk', 'description': 'Qbox is the dedicated Elasticsearch hosting solution. Our purpose is to help you be successful in your Elasticsearch environment and take away the stress of ...', 'site_name': 'YouTube', 'keywords': ['Elasticsearch', 'Cloud', 'Hosted Elasticsearch'], 'locale': 'en_US', 'status_code': 200}
```
 on verifie que nous ne recevons aucun résultats si la requête est fausse :
```
es.indices.refresh(index="fake-index")
res = es.search(index="fake-index", body={"query": {"match_all": {}}})
print("Got %d Hits:" % res['hits']['total'])
for hit in res['hits']['hits']:
    print(hit["_source"])
```
Nous obtenons ce résultats:
```
POST https://$BASE_URL/fake-index/_refresh [status:404 request:0.036s]
Traceback (most recent call last):
  File "lassie_qbox.py", line 26, in <module>
    es.indices.refresh(index="fake-index")
  File "/usr/lib/python3.6/site-packages/elasticsearch/client/utils.py", line 71, in _wrapped
    return func(*args, params=params, **kwargs)
  File "/usr/lib/python3.6/site-packages/elasticsearch/client/indices.py", line 56, in refresh
    '_refresh'), params=params)
  File "/usr/lib/python3.6/site-packages/elasticsearch/transport.py", line 318, in perform_request
    status, headers, data = connection.perform_request(method, url, params, body, ignore=ignore, timeout=timeout)
  File "/usr/lib/python3.6/site-packages/elasticsearch/connection/http_urllib3.py", line 127, in perform_request
    self._raise_error(response.status, raw_data)
  File "/usr/lib/python3.6/site-packages/elasticsearch/connection/base.py", line 122, in _raise_error
    raise HTTP_EXCEPTIONS.get(status_code, TransportError)(status_code, error_message, additional_info)
elasticsearch.exceptions.NotFoundError: TransportError(404, 'index_not_found_exception', 'no such index')
```
Nous n'avons plus qu'à remplacer les test fichiers par les liens que nous voulons indexé 
