# Configure Jenkins

## Install and Setup Jenkins Jenkins on Ubuntu

0. Install Java

1. Install Jenkins
    - curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
        /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    - echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
        https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null
    - sudo apt-get update
    - sudo apt-get install jenkins
2. Setup
    - sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    - Click Install suggested plugins

## Update visudo and assign administration privileges to jenkins user
- sudo nano /etc/sudoers --> Add the following line at the end of the file: jenkins ALL=(ALL) NOPASSWD: ALL 
- sudo su - jenkins  

## Install Docker
- sudo apt install docker.io
- Add jenkins user to Docker group: sudo usermod -aG docker jenkins 

## Install and Setup AWS CLI
- sudo apt install awscli 
- aws configure :   AWS Access Key ID [None]:
                    AWS Secret Access Key [None]:
                    Default region name [None]:
                    Default output format [None]:

## Install and Setup Kubectl
- curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
- chmod +x ./kubectl 
- sudo mv ./kubectl /usr/local/bin

## Install Helm
- curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
- sudo apt-get install apt-transport-https --yes
- echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
- sudo apt-get update
- sudo apt-get install helm