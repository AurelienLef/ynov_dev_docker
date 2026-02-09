# Résponses

## Exercie 1

```
docker build -t eval-app:v1 .

docker run -d -p 3001:3000 eval-app:v1

curl http://localhost:3001
{"message":"Hello from Docker!","timestamp":"2026-02-09T11:47:56.983Z","hostname":"c6164dc826d0"}

docker images eval-app:v1
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
eval-app     v1        09932060b0d9   5 minutes ago   180MB
```

Pour voir le nombre de layers et l'historique, ici 15 :
```
docker history eval-app:v1
```


## Exercice 2 :



## Exercice 3

```
docker build --build-arg NODE_VERSION=20 -t eval-app:v3-node20 -f Dockerfile.v3 .

docker run -d -p 3002:3000 -e APP_ENV=development eval-app:v3-node20

curl http://localhost:3002
{"message":"Hello from Docker!","environment":"development","timestamp":"2026-02-09T14:11:35.172Z","hostname":"27da374be0a2"}
```

Quelle est la différence entre ARG et ENV ?
..

Comment passer une variable d'environnement au docker run ?
Avec -e nom=valeur


## Exercice 4

Port 5000 déjà pris par le système.
```
docker build -t eval-flask:v1 .

docker run -d --name flask-test -p 5001:5000 eval-flask:v1

docker inspect flask-test
"Status": "starting",
```