# nexsius_infra [![Build Status](https://travis-ci.com/otus-devops-2019-02/nexsius_infra.svg?branch=ansible-2)](https://travis-ci.com/otus-devops-2019-02/nexsius_infra)

#HW 11
## Сделано:
 * создан общий плейбук с тегами
 * создан плейбук из нескольких play
 * разнесе на отдельные плейбуки
 * настроен inventory.sh для автоматического заполнения адреса БД в плейбук
 * созданы плейбуки деплоя образов packer
 Приложение разворачивается запуском скрипта ansible_deploy.sh в корне репозитория, предварительно установив образы в terraform.tfvars на reddit-app-base-ansible и reddit-db-base-ansible:
```
#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' # No Color
CY='\033[1;36m'

echo -e "${RED}Starting deploy reddit app...."
sleep .5
echo -e "${NC}creating image for app server..."
packer build -var-file=packer/variables.json -force packer/app.json && echo -e "${CY}Done!${NC}"
sleep .5
echo -e "creating image for ${RED}db server${NC}..."
packer build -var-file=packer/variables.json -force packer/db.json && echo -e "${CY}Done!${NC}"
sleep .5
echo -e "deploy servers with ${RED}terraform${NC}..."
cd terraform/stage && terraform apply --auto-approve && echo -e "${CY}Done!${NC}"
sleep .5
echo -e "configuring environment and ${RED}deploy app${NC}..."
cd ../../ansible && ansible-playbook site.yml && echo -e "${CY}Done!${NC}"
sleep .5
echo "Checking connection"
curl -I `cat ../app_ip.log`:9292
```
