# docker build -t $MYACR.azurecr.io/spring-petclinic-api-gateway:$VERSION \
#     --build-arg ARTIFACT_NAME=spring-petclinic-api-gateway-$VERSION.jar \
#     --build-arg APP_PORT=8080 \
#     .

# docker image list
   
# docker push $MYACR.azurecr.io/spring-petclinic-api-gateway:$VERSION

# admin server
docker buildx build -t $MYACR.azurecr.io/spring-petclinic-admin-server:$VERSION \
    --build-arg ARTIFACT_NAME=spring-petclinic-admin-server-$VERSION.jar \
    --build-arg APP_PORT=8080 .

# api gateway
docker buildx build -t $MYACR.azurecr.io/spring-petclinic-api-gateway:$VERSION \
    --build-arg ARTIFACT_NAME=spring-petclinic-api-gateway-$VERSION.jar \
    --build-arg APP_PORT=8080 .

# # config server
docker buildx build -t $MYACR.azurecr.io/spring-petclinic-config-server:$VERSION \
    --build-arg ARTIFACT_NAME=spring-petclinic-config-server-$VERSION.jar \
    --build-arg APP_PORT=8080 .

# customers service
docker buildx build -t $MYACR.azurecr.io/spring-petclinic-customers-service:$VERSION \
    --build-arg ARTIFACT_NAME=spring-petclinic-customers-service-$VERSION.jar \
    --build-arg APP_PORT=8080 .

# # discovery server
docker buildx build -t $MYACR.azurecr.io/spring-petclinic-discovery-server:$VERSION \
    --build-arg ARTIFACT_NAME=spring-petclinic-discovery-server-$VERSION.jar \
    --build-arg APP_PORT=8080 .

# # messaging emulator
# docker buildx build -t $MYACR.azurecr.io/spring-petclinic-messaging-emulator:$VERSION \
#     --build-arg ARTIFACT_NAME=spring-petclinic-messaging-emulator-$VERSION.jar \
#     --build-arg APP_PORT=8080 .

# vets service
docker buildx build -t $MYACR.azurecr.io/spring-petclinic-visits-service:$VERSION \
    --build-arg ARTIFACT_NAME=spring-petclinic-visits-service-$VERSION.jar \
    --build-arg APP_PORT=8080 .

# vets service
docker buildx build -t $MYACR.azurecr.io/spring-petclinic-vets-service:$VERSION \
    --build-arg ARTIFACT_NAME=spring-petclinic-vets-service-$VERSION.jar \
    --build-arg APP_PORT=8080 .


# List images
docker image list

# Push images to ACR
docker push $MYACR.azurecr.io/spring-petclinic-admin-server:$VERSION
docker push $MYACR.azurecr.io/spring-petclinic-api-gateway:$VERSION
docker push $MYACR.azurecr.io/spring-petclinic-config-server:$VERSION
docker push $MYACR.azurecr.io/spring-petclinic-customers-service:$VERSION
docker push $MYACR.azurecr.io/spring-petclinic-discovery-server:$VERSION
#docker push $MYACR.azurecr.io/spring-petclinic-messaging-emulator:$VERSION
docker push $MYACR.azurecr.io/spring-petclinic-visits-service:$VERSION
docker push $MYACR.azurecr.io/spring-petclinic-vets-service:$VERSION


# List the images in the ACR
az acr repository list -n $MYACR


