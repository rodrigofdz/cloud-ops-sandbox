 #!/bin/bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

# install kubectl
sudo apt-get -y install git kubectl

# install go
curl -O https://storage.googleapis.com/golang/go1.12.9.linux-amd64.tar.gz
tar -xvf go1.12.9.linux-amd64.tar.gz
sudo chown -R root:root ./go
sudo mv go /usr/local
echo 'export GOPATH=$HOME/go' >> ~/.profile
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.profile
source ~/.profile

# install addlicense
go get -u github.com/google/addlicense
sudo ln -s $HOME/go/bin/addlicense /bin

# install kind
curl -Lo ./kind "https://github.com/kubernetes-sigs/kind/releases/download/v0.7.0/kind-$(uname)-amd64" && \
chmod +x ./kind && \
sudo mv ./kind /usr/local/bin

# install skaffold
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
chmod +x skaffold && \
sudo mv skaffold /usr/local/bin

# install docker
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
sudo apt update && \
sudo apt install -y docker-ce && \
sudo usermod -aG docker ${USER}

# reboot to complete docker setup
sudo reboot
