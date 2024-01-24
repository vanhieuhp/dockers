PROJECT_WORKSPACE:= /home/vanhieu/data/bluebottle/fandelo
BASE_WORKSPACE:= /home/vanhieu/data/docker/fanone
COMMON_PATH = $(PROJECT_WORKSPACE)/fandelo-one-common
COMMON_SPRING_PATH = $(PROJECT_WORKSPACE)/fandelo-one-common-spring
CLIENT = fandelo-one-client
TALENT = fandelo-one-common
MEDIA = fandelo-one-media
GATEWAY = fandelo-one-gateway
USER = fandelo-one-user
MAIL = fandelo-one-mail
BRANCH = develop
AWS_URI = 186579991713.dkr.ecr.ap-southeast-1.amazonaws.com

common:
	@cd $(COMMON_PATH) && git fetch && git checkout $(BRANCH) -f && git pull origin $(BRANCH) 
	$(COMMON_PATH)/gradlew clean build publishToMavenLocal --project-dir $(COMMON_PATH)

common-spring:
	@cd $(COMMON_SPRING_PATH) && git fetch && git checkout $(BRANCH) -f && git pull origin $(BRANCH)
	$(COMMON_SPRING_PATH)/gradlew clean build publishToMavenLocal --project-dir $(COMMON_SPRING_PATH)

gateway-build:
	@cp -r $(PROJECT_WORKSPACE)/$(GATEWAY) $(BASE_WORKSPACE)

	@cd $(BASE_WORKSPACE)/$(GATEWAY) && git fetch && git checkout -f $(BRANCH) && git pull origin $(BRANCH)
	
	@cp properties/gateway/application-dev.yaml $(BASE_WORKSPACE)/$(GATEWAY)/src/main/resources/application-dev.yaml
	@cp properties/gateway/policy-enforcer-dev.yaml $(BASE_WORKSPACE)/$(GATEWAY)/src/main/resources/policy-enforcer-dev.yaml
	
	$(BASE_WORKSPACE)/$(GATEWAY)/gradlew clean bootJar --project-dir $(BASE_WORKSPACE)/$(GATEWAY) --stacktrace --info
	
	@mv $(BASE_WORKSPACE)/$(GATEWAY)/build/libs/*.jar $(BASE_WORKSPACE)/jar
	
	DOCKER_BUILDKIT=1 docker build --no-cache --target gateway -t gateway:1.0 .
	rm -rf $(BASE_WORKSPACE)/$(GATEWAY)


gateway-docker: gateway-build
	@docker compose kill gateway

	@docker compose rm gateway -f

	@docker compose up gateway -d || echo ""
	@docker compose up gateway -d

gateway-aws: gateway-build
	aws ecr get-login-password --region ap-southeast-1 --profile vanhieuit10-aws | docker login --username AWS --password-stdin $(AWS_URI)
	docker tag gateway:1.0 $(AWS_URI)/appone/gateway:1.0
	docker push $(AWS_URI)/appone/gateway:1.0

user-build:
	@cp -r $(PROJECT_WORKSPACE)/$(USER) $(BASE_WORKSPACE)

	@cd $(BASE_WORKSPACE)/$(USER) && git fetch && git checkout -f $(BRANCH) && git pull origin $(BRANCH)

	@cp properties/user/dev_mysql.properties $(BASE_WORKSPACE)/$(USER)/src/main/conf/dev/dev_mysql.properties
	@cp properties/user/application-dev.yaml $(BASE_WORKSPACE)/$(USER)/src/main/resources/application-dev.yaml
	@cp properties/user/dev_redisson.yaml $(BASE_WORKSPACE)/$(USER)/src/main/conf/dev/dev_redisson.yaml
	
	$(BASE_WORKSPACE)/$(USER)/gradlew clean bootJar --project-dir $(BASE_WORKSPACE)/$(USER) --stacktrace --info
	
	@mv $(BASE_WORKSPACE)/$(USER)/build/libs/*.jar $(BASE_WORKSPACE)/jar

	@DOCKER_BUILDKIT=1 docker build --no-cache --target user -t user:1.0 .
	@rm -rf $(BASE_WORKSPACE)/$(USER)

user-docker: user-build
	@docker compose kill user

	@docker compose rm user -f

	@docker compose up user -d

user-aws: user-build
	aws ecr get-login-password --region ap-southeast-1 --profile vanhieuit10-aws | docker login --username AWS --password-stdin $(AWS_URI)
	docker tag user:1.0 $(AWS_URI)/appone/user:1.0
	docker push $(AWS_URI)/appone/user:1.0


mail-build:
	
	@rm -rf $(BASE_WORKSPACE)/$(MAIL) || echo "Mail build"
	@cp -r $(PROJECT_WORKSPACE)/$(MAIL) $(BASE_WORKSPACE)

	@cd $(BASE_WORKSPACE)/$(MAIL) && git fetch && git checkout -f $(BRANCH) && git pull origin $(BRANCH)

	@cp $(BASE_WORKSPACE)/properties/mail/application-dev.properties $(BASE_WORKSPACE)/$(MAIL)/src/main/resources/application-dev.properties
	
	$(BASE_WORKSPACE)/$(MAIL)/gradlew clean bootJar --project-dir $(BASE_WORKSPACE)/$(MAIL) --stacktrace --info
	
	@mv $(BASE_WORKSPACE)/$(MAIL)/build/libs/*.jar $(BASE_WORKSPACE)/jar

	@DOCKER_BUILDKIT=1 docker build --no-cache --target mail -t mail:1.0 .
	@rm -rf $(BASE_WORKSPACE)/$(MAIL)

mail-docker: user-build
	@docker compose kill mail

	@docker compose rm mail -f

	@docker compose up mail -d

mail-aws:
	aws ecr get-login-password --region ap-southeast-1 --profile vanhieuit10-aws | docker login --username AWS --password-stdin $(AWS_URI)
	docker tag mail:1.0 $(AWS_URI)/appone/mail:1.0
	docker push $(AWS_URI)/appone/mail:1.0