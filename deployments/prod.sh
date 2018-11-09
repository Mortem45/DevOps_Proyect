wget -O /temp/packer.zip https://releases.hashicorp.com/packer/1.3.2/packer_1.3.2_linux_amd64.zip
wget -O /temp/terraform.zip https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
unzip tmp/packer.zip -d ~/bin
unzip tmp/terraform.zip -d ~/bin
packer validate deployments/template.json &&
packer build deployments/template.json &&
export TF_VAR_image_id=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer 82a18e068538217fd63cc3aecca708095701776d9e23d729a3af9077e38e25c2" "https://api.digitalocean.com/v2/images?private=true" | jq ."images[] | select(.name == \"ProyectAtlas-Snapshot-$CIRCLE_BUILD_NUM\") | .id")
echo $TF_VAR_image_id
cd infrastructure && **terraform init -input=false** && **terraform apply -input=false -auto-approve** && cd .. &&
git add infrastructure && git commit -m "Deplyed $CIRCLE_BUILD_NUM [skip ci]" &&
git push origin master