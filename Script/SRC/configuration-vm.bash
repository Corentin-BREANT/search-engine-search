 #!/bin/bash
 
# Création du disque dur virtuel
echo "Creation du fichier disque dur ($vdi_file)"
cp $vbox_home/VDI/deb5-server.vdi $vdi_file
VBoxManage internalcommands sethduuid $vdi_file
echo "Opening virtual hard drive disk ($vdi_file)"
VBoxManage openmedium disk $vdi_file

$vbox_home/Machines/ --ostype Lubuntu --register
VBoxManage modifyvm $nom_vm --memory 512 
VBoxManage modifyvm $nom_vm --nic2 hostonly --hostonlyadapter2 vboxnet0
 
echo "Ajout du disque dur à la machine virtuel"
VBoxManage storagectl $nom_vm --name "Contrôleur IDE" --add ide
VBoxManage storageattach $nom_vm --storagectl "Contrôleur IDE" --port 0 --device 0 --type hdd --medium $vdi_file