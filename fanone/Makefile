PROJECT_WORKSPACE:= /home/hieujr/data/bluebottle/fandelo
BASE_WORKSPACE:= /home/hieujr/data/docker/fanone
COMMON_PATH = $(PROJECT_WORKSPACE)/fandelo-one-common
COMMON_SPRING_PATH = $(PROJECT_WORKSPACE)/fandelo-one-common-spring
CLIENT = fandelo-one-client
TALENT = fandelo-one-common
MEDIA = fandelo-one-media
GATEWAY = fandelo-one-gateway
USER = fandelo-one-user

common:
	@cd $(COMMON_PATH) && git checkout master -f && git pull origin master 
	$(COMMON_PATH)/gradlew clean build publishToMavenLocal --project-dir $(COMMON_PATH)

common-spring:
	@cd $(COMMON_SPRING_PATH) && git checkout master -f && git pull origin master
	$(COMMON_SPRING_PATH)/gradlew clean build publishToMavenLocal --project-dir $(COMMON_SPRING_PATH)
	
client:
	@cp -r $(PROJECT_WORKSPACE)/$(CLIENT) $(BASE_WORKSPACE)

	@cp properties/client_dev_mysql.properties $(BASE_WORKSPACE)/$(CLIENT)/src/main/conf/dev/dev_mysql.properties
	
	$(BASE_WORKSPACE)/$(CLIENT)/gradlew clean bootJar --project-dir $(BASE_WORKSPACE)/$(CLIENT) --stacktrace --info
	
	@mv $(BASE_WORKSPACE)/$(CLIENT)/build/libs/*.jar $(BASE_WORKSPACE)/jar

gateway:
	@rm -rf $(GATEWAY)
	@cp -r $(PROJECT_WORKSPACE)/$(GATEWAY) $(BASE_WORKSPACE)

	@cd $(BASE_WORKSPACE)/$(GATEWAY) && git checkout -f master && git pull origin master
	
	@cp properties/gateway-application-dev.yaml $(BASE_WORKSPACE)/$(GATEWAY)/src/main/resources/application-dev.yaml
	@cp properties/gateway-policy-enforcer-dev.json $(BASE_WORKSPACE)/$(GATEWAY)/src/main/resources/policy-enforcer-dev.json
	
	$(BASE_WORKSPACE)/$(GATEWAY)/gradlew clean bootJar --project-dir $(BASE_WORKSPACE)/$(GATEWAY) --stacktrace --info
	
	@mv $(BASE_WORKSPACE)/$(GATEWAY)/build/libs/*.jar $(BASE_WORKSPACE)/jar
	
	@DOCKER_BUILDKIT=1 docker build --no-cache --target gateway -t gateway:1.0 . 

	@docker compose kill gateway

	@docker compose rm gateway -f

	@docker compose up gateway -d || echo ""
	@docker compose up gateway -d

user:
	@rm -rf $(USER)
	@cp -r $(PROJECT_WORKSPACE)/$(USER) $(BASE_WORKSPACE)

	@cd $(BASE_WORKSPACE)/$(USER) && git checkout -f master && git pull origin master

	@cp properties/user_dev_mysql.properties $(BASE_WORKSPACE)/$(USER)/src/main/conf/dev/dev_mysql.properties
	@cp properties/user-application-dev.yaml $(BASE_WORKSPACE)/$(USER)/src/main/resources/application-dev.yaml
	@cp properties/user_dev_redisson.yaml $(BASE_WORKSPACE)/$(USER)/src/main/conf/dev/dev_redisson.yaml
	
	$(BASE_WORKSPACE)/$(USER)/gradlew clean bootJar --project-dir $(BASE_WORKSPACE)/$(USER) --stacktrace --info
	
	@mv $(BASE_WORKSPACE)/$(USER)/build/libs/*.jar $(BASE_WORKSPACE)/jar

	@DOCKER_BUILDKIT=1 docker build --no-cache --target user -t user:1.0 .

	@docker compose kill user

	@docker compose rm user -f

	@docker compose up user -d
