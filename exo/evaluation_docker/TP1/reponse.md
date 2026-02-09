# Résponses

## Exercie 1

### 1.1

```
docker --version

Docker version 28.1.1, build 4eba377
```

### 1.2

```
docker pull nginx:alpine
docker pull redis:7-alpine

docker images
nginx   alpine     1d13701a5f9f   4 days ago    91.7MB
redis   7-alpine   02f2cc4882f8   12 days ago   61.4MB
```

On utilise des images alpine car elles sont plus légère que les autres.

### 1.3

```
docker images
```

Il y a 24 images


## Exercice 2

### 2.1

````
docker run -d --name web-eval -p 8000:8000 nginx:alpine
````

### 2.2

```
docker inspect web-eval
```

IP : 172.17.0.2
État : running
Date creéation : 2026-02-09T10:27:55.583535959Z

### 2.3

```
docker logs --tail 10 web-eval   
2026/02/09 10:27:56 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/02/09 10:27:56 [notice] 1#1: start worker processes
2026/02/09 10:27:56 [notice] 1#1: start worker process 30
2026/02/09 10:27:56 [notice] 1#1: start worker process 31
2026/02/09 10:27:56 [notice] 1#1: start worker process 32
2026/02/09 10:27:56 [notice] 1#1: start worker process 33
2026/02/09 10:27:56 [notice] 1#1: start worker process 34
2026/02/09 10:27:56 [notice] 1#1: start worker process 35
2026/02/09 10:27:56 [notice] 1#1: start worker process 36
2026/02/09 10:27:56 [notice] 1#1: start worker process 37

docker top web-service
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                1337                1292                0                   10:27               ?                   00:00:00            nginx: master process nginx -g daemon off;
statd               1439                1337                0                   10:27               ?                   00:00:00            nginx: worker process
statd               1440                1337                0                   10:27               ?                   00:00:00            nginx: worker process
statd               1441                1337                0                   10:27               ?                   00:00:00            nginx: worker process
statd               1442                1337                0                   10:27               ?                   00:00:00            nginx: worker process
statd               1443                1337                0                   10:27               ?                   00:00:00            nginx: worker process
statd               1444                1337                0                   10:27               ?                   00:00:00            nginx: worker process
statd               1445                1337                0                   10:27               ?                   00:00:00            nginx: worker process
statd               1446                1337                0                   10:27               ?                   00:00:00            nginx: worker process
```

### 2.4

```
docker exec -it web-eval /bin/sh

echo "Aurélien Lefebvre" > /tmp/evaluation.txt
ls /tmp
    evaluation.txt

exit
```


## Exercice 3

### 3.1

```
docker stop web-eval

docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

docker restart web-eval

docker exec -it web-eval /bin/sh
ls /tmp
    evaluation.txt
```

Le fichier existe toujours car le conteneur à été stoppé et non supprimé.

### 3.2

```
docker run -d --name cache-eval redis:7-alpine

docker exec -it cache-eval redis-cli
SET evaluation "reussie"
    OK
GET evaluation
    "reussie"
```

### 3.3

```
docker ps -a

CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS                     PORTS      NAMES
397761a40dc6   redis:7-alpine             "docker-entrypoint.s…"   2 minutes ago    Up 2 minutes               6379/tcp   cache-eval
efbff30c8f12   nginx:alpine               "/docker-entrypoint.…"   22 minutes ago   Exited (0) 3 minutes ago              web-eval
8d83d05bc67f   phpmyadmin:5               "/docker-entrypoint.…"   2 weeks ago      Exited (0) 8 minutes ago              wp_phpmyadmin
ec90f6fea794   mysql:8.0                  "docker-entrypoint.s…"   2 weeks ago      Exited (0) 8 minutes ago              wp_mysql
0b5a6084689a   052b75ab72f6               "/docker-entrypoint.…"   7 weeks ago      Exited (0) 8 minutes ago              wordpress_nginx
a60869d21aea   phpmyadmin:latest          "/docker-entrypoint.…"   7 weeks ago      Exited (0) 8 minutes ago              wordpress_phpmyadmin
1c60b6411bd2   wordpress:6.4-php8.2-fpm   "docker-entrypoint.s…"   7 weeks ago      Exited (0) 8 minutes ago              wordpress_app
0c593afcb858   ee64a64eaab6               "docker-entrypoint.s…"   7 weeks ago      Exited (0) 8 minutes ago              wordpress_redis
cf138fa74a29   mysql:8.0                  "docker-entrypoint.s…"   7 weeks ago      Exited (0) 8 minutes ago              wordpress_mysql
1ba335565900   mailhog/mailhog            "MailHog"                7 weeks ago      Exited (2) 8 minutes ago              wordpress_mailhog

docker stop $(docker ps -a -q)

docker system prunedocker rm $(docker ps -a -q)
```

docker stop arrête le conteneur alors qur rm lui le supprime.


## Exercice 4

### 4.1

```
docker volume create data-eval
```

### 4.2

```
docker run -d --name alpine-eval -v data-eval:/data alpine sh -c "echo 'Ceci est persistant' > /data/persistant.txt"
```

### 4.3

```
docker run -d --name alpine-eval2 -v data-eval:/data alpine

docker run --name alpine-eval2 -v data-eval:/data alpine cat /data/persistant.txt
Ceci est persistant
```

Le fichier à été sauvegarder dans un volume et non dans le conteneur, de ce fait si on réutilise ce même volume dans d'autres conteneurs ce qu'il contient, ici le fichier persistant.txt, est est présent.