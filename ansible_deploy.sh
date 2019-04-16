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
