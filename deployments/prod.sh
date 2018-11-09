wget -O packer.zip https://releases.hashicorp.com/packer/1.3.2/packer_1.3.2_linux_amd64.zip
unzip packer.zip
./packer validate deployments/template.json
./packer build deployments/template.json