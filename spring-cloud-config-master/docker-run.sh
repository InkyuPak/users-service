
docker network ls -a
docker network create --gateway 172.18.0.1 --subnet 172.18.0.0/16 ecommerce-network    
docker network inspect ecommerce-network  

# Microservice docker 
docker run -d --name rabbitmq --network ecommerce-network \
 -p 15672:15672 -p 5672:5672 -p 15671:15671 -p 5671:5671 -p 4369:4369 \
 -e RABBITMQ_DEFAULT_USER=guest \
 -e RABBITMQ_DEFAULT_PASS=guest rabbitmq:management

docker run -d -p 8888:8888 --network ecommerce-network \
 -e "spring.rabbitmq.host=rabbitmq" \
 -e "spring.profiles.active=default" \
  --name config-service swjo0330/config-service:1.0

docker run -d -p 8761:8761 --network ecommerce-network \
 -e "spring.cloud.config.uri=http://config-service:8888" \
 --name discovery-service swjo0330/discovery-service:1.0

docker run -d -p 8000:8000 --network ecommerce-network \
 -e "spring.cloud.config.uri=http://config-service:8888" \
 -e "spring.rabbitmq.host=rabbitmq" \
 -e "eureka.client.serviceUrl.defaultZone=http://discovery-service:8761/eureka/" \
 --name apigateway-service \
 swjo0330/apigateway-service:1.0


docker run -d -p 3306:3306  --network ecommerce-network --name mariadb swjo0330/my-mariadb:1.0

docker-compose -f docker-compose-single-broker.yml up -d

docker run -d -p 9411:9411 --network ecommerce-network --name zipkin openzipkin/zipkin

docker run -d -p 9090:9090 \
 --network ecommerce-network \
 --name prometheus \
 -v /Users/joseong-won/springcloud/prometheus/prometheus-2.34.0.darwin-amd64/prometheus-docker.yml:/etc/prometheus/prometheus.yml \
 prom/prometheus 

docker run -d -p 3000:3000 \
 --network ecommerce-network \
 --name grafana \
 grafana/grafana 


docker run --name redis -p 6379:6379 \
 --network ecommerce-network \
 -v /Users/joseong-won/springcloud/docker/redis-db/redisvolume:/data \
 -d redis:latest redis-server --appendonly yes

docker run -d -p 55432:5432 -e POSTGRES_PASSWORD="385" --name my-postgre postgres


docker run -d --network ecommerce-network \
 -e "spring.cloud.config.uri=http://config-service:8888" \
 -e "spring.rabbitmq.host=rabbitmq" \
 -e "spring.redis.host=redis" \
 -e "eureka.client.serviceUrl.defaultZone=http://discovery-service:8761/eureka/" \
 --name authentication-service \
 swjo0330/authentication-service:1.0

docker run -d --network ecommerce-network \
  --name user-service \
 -e "spring.cloud.config.uri=http://config-service:8888" \
 -e "spring.rabbitmq.host=rabbitmq" \
 -e "spring.zipkin.base-url=http://zipkin:9411" \
 -e "eureka.client.serviceUrl.defaultZone=http://discovery-service:8761/eureka/" \
 -e "logging.file=/api-logs/users-ws.log" \
 swjo0330/user-service:1.0

docker run -d --network ecommerce-network \
  --name order-service \
 -e "spring.cloud.config.uri=http://config-service:8888" \
 -e "spring.rabbitmq.host=rabbitmq" \
 -e "spring.zipkin.base-url=http://zipkin:9411" \
 -e "eureka.client.serviceUrl.defaultZone=http://discovery-service:8761/eureka/" \
 -e "spring.datasource.url=jdbc:mariadb://mariadb:3306/mydb" \
 -e "logging.file=/api-logs/orders-ws.log" \
 swjo0330/order-service:1.0


docker run -d --network ecommerce-network \
  --name catalog-service \
 -e "spring.cloud.config.uri=http://config-service:8888" \
 -e "spring.rabbitmq.host=rabbitmq" \
 -e "eureka.client.serviceUrl.defaultZone=http://discovery-service:8761/eureka/" \
 -e "logging.file=/api-logs/catalogs-ws.log" \
 swjo0330/catalog-service:1.0

#  (:ro is optional for read only)
# -v $(pwd)/secret-files/certificates/verisign.keystore:$CONFIG_PATH/certificates/verisign.keystore:ro \
# -v $(pwd)/secret-files/certificates/fuse/:$CONFIG_PATH/certificates/fuse/:ro \


###################### gcsv1-service ######################
#  docker run -d --network ecommerce-network \
#   --name gcs-service \
#    -v ~/DROW/logs:/var/logs \
#    -p 80:80 -p 6760:6760 -p 14550:14550/udp \
#    -e "server.port=80" \
#    -e "logging.file=/var/logs/app.log" \
#    -e "eureka.client.fetch-registry=false" \
#    -e "eureka.client.register-with-eureka=false" \
#    swjo0330/gcs-service:1.0

docker run -d --network ecommerce-network \
--name gcsv1-service \
-v C:\Users\clrobur\DROW\logs:/var/logs \
-v C:\Users\clrobur\DROW\Server\opt\download\sim:/var/sim \
-p 80:80 -p 6760:6760 -p 14550:14550/udp \
-e "server.port=80" \
-e "logging.file=/var/logs/app.log" \
-e "user.home=/var" \
-e "spring.load.auto-sim=/var/sim" \
-e "eureka.client.fetch-registry=false" \
-e "eureka.client.register-with-eureka=false" \
swjo0330/gcsv1-service:1.0


###################### drow-main-service ######################
docker run -d --network ecommerce-network \
--name drow-main-service \
-v C:\Users\clrobur\DROW\logs:/var/logs \
-v C:\Users\clrobur\DROW\Server\opt\download\sim:/var/sim \
-p 8181:80 -p 6760:6760 -p 14550:14550/udp \
-e "server.port=8181" \
-e "logging.file.path=/var/logs" \
-e "user.home=/var" \
swjo0330/drow-main-service:1.0

docker run -d --network ecommerce-network \
--name drow-main-service \
-v /Users/joseong-won/DROW\logs:/var/logs \
-v /Users/joseong-won/DROW\Server\opt\download\sim:/var/sim \
-p 8181:80 -p 6760:6760 -p 14550:14550/udp \
-e "logging.file.path=/var/logs" \
-e "user.home=/var" \
swjo0330/drow-main-service:1.0

docker run -d --name gcs-service-GS \
--network ecommerce-network\
-v /C/Users/clrobur/DROW/logs:/var/logs \
-v /C/Users/clrobur/DROW/Server/opt/download/sim:/var/sim \
-p 80:80 -p 6760:6760 -p 14550:14550/udp -e "server.port=80" \
-e "spring.datasource.url=jdbc:log4jdbc:postgresql://GS-DB:5432/clrobur" \
-e "logging.file=/var/logs/app.log" \
-e "user.home=/var" \
-e "eureka.client.fetch-registry=false" \
-e "eureka.client.register-with-eureka=false" \
223.130.161.121:5000/gcsv1-service:1.0-gs