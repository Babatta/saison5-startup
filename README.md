# Configuration de l'environnement de dev avec dind(docker in docker)

creer le dossier de de notre projet:
mkdir startup-en-louse
cd startup-en-louse
mkdir .devcontainer/
touch README.md 
cd .devcontainer/
touch devcontainer.json
touch docker-compose.yml

cd ..
code ..

# cConfiguration de Docker-in-Docker en ajoutant les extentions necessaire.
dans devcontainer.json

'''
{
  "name": "Docker-in-Docker Devcontainer",
  "dockerComposeFile": "docker-compose.yml",
  "service": "dind",
  "workspaceFolder": "/workspace",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-azuretools.vscode-docker",
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode"
      ],
      "settings": {
        "terminal.integrated.shell.linux": "/bin/bash",
        "docker.host": "tcp://localhost:2375"
      }
    }
  },
  "postCreateCommand": "docker --version && echo 'Docker-in-Docker setup complete.'",
  "remoteUser": "vscode"
}
'''

et dans docker-compose.yml

'''

version: '3.8'

services:
  dind:
    image: docker:24.0.2-dind
    privileged: true
    environment:
      - DOCKER_TLS_CERTDIR=""
    volumes:
      - dind_storage:/var/lib/docker  # Persistance des données Docker (images et conteneurs)
    ports:
      - "2375:2375"  # Expose le démon Docker sans TLS sur le port 2375

volumes:
  dind_storage:

'''

## Démarrage du Devcontainer

1. Ouvrez le projet dans **Visual Studio Code**.
2. Lancez le Devcontainer en sélectionnant **Remote-Containers: Reopen in Container** depuis la palette de commandes (F1).
3. Une fois le Devcontainer lancé, vous pouvez exécuter des commandes Docker.

## Vérification de Docker-in-Docker

Pour vérifier que l'environnement Docker fonctionne correctement dans le Devcontainer :

1. **Lancer Hello World** :

   ```bash
   docker run hello-world
