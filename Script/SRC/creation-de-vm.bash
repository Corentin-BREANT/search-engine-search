#!/bin/sh
vbox_home=`pwd`/`dirname $0`
vm_name=$1
vdi_file=$vbox_home/VDI/$(echo $nom_vm | tr "[:upper:]" "[:lower:]").vdi

# Création de la machine virtuelle
echo "Creation de la machine virtuelle $nom_vm"
VBoxManage createvm --name $nom_vm --basefolder 

