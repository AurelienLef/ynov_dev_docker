Partie 1 :
docker pull amigoscode/2048

docker images

docker run -d -it --name jeu-aurelien -p 8080:80 amigoscode/2048

docker ps

docker run -d -it --name jeu-aurelien -p 8081:80 amigoscode/2048

docker ps

docker stop

docker start jeu2-aurelien

docker ps -a


Partie 2 :
docker pull nginx

docker run -d -it --name nginx-web -p 8080:80 nginx

docker ps

docker exec -it nginx-web sh

