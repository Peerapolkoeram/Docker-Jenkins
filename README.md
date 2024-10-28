# Docker Compose for Jenkins

***
### run docker compose
 ``` shell
 docker compose up -d
 ```
### download json-path-api.hpi (If error case dependencies)
 ``` shell
 cp json-path-api.hpi /var/jenkins_home/plugins/
 ```
### get into the container
 ``` shell
 docker exec -it {container name or container ID} bash
 ```
## or
 ``` shell
 docker exec -it {container name or container ID} sh
 ```