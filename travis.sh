#!/bin/bash
PACKER_TMPL=`find packer/ -name "*.json"`
echo $PACKER_TMPL
for f in $PACKER_TMPL:
do
  packer validate -var-file=packer/variables.json.example $f
done
