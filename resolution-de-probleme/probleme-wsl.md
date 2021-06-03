Problème encouru avec WSL2
==========================

Mon principal problème avec WSL2 à était après l'installation de WSL, le moment où nous devons mettre en version par défaut de WSL, WSL2 (pour plus d'informations ce référé à la documentation ajouter dans la [Webographie](https://github.com/Corentin-BREANT/search-engine-search/blob/main/webographie.md) ) la commande étant :

```wsl --set-default-version 2 ```

en effet un message d'erreur s'afficher dans PowerShell me disant qu'il ne reconnaissait pas ma commande comme si-dessous:

```Error: 0x1bc For information on key differences with WSL 2 please visit https://aka.ms/wsl2 ```

à cause de ce message d'erreur aucune commande WSL fonctionnait, après plusieurs essai de ma part j'ai finallement essayé de continuer ce que la documentation disait en me disant que je ressayerais plus tard, après ça j'ai découvert qui, contrairement à ce que la documentation laisser penser, il fallait tout d'abord installer via le microsoft store Ubuntu (ou d'autre support Linux) pour que WSL n'affiche plus l'erreur
Après installation j'ai obtenue donc ce résulats

![](http://image.noelshack.com/fichiers/2021/22/4/1622714971-screen-powershell-wsl.png)
