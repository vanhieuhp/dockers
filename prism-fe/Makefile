PROJECT_WORKSPACE:= ~/data/bluebottle/prism/prism-frontend
DOCKER_WORKSPACE:= ~/data/docker/prism-fe
BACKEND_API:=/api
WS_API:=ws://rabbitmq:15674/ws

compress:
	
	rm -rf $(PROJECT_WORKSPACE)/portal | echo ""
	rm -rf $(DOCKER_WORKSPACE)/workspace/portal | echo ""
	
	cd $(PROJECT_WORKSPACE) && git reset --h
# cd $(PROJECT_WORKSPACE) && git reset --h && git checkout test 
	
	sed -i -e 's|var PRISM_API_URL.*;|var PRISM_API_URL = "$(BACKEND_API)";|g' $(PROJECT_WORKSPACE)/src/app/api/api.js
	sed -i -e 's|var PRISM_STOMP_URL.*;|var PRISM_STOMP_URL = "$(WS_API)";|g' $(PROJECT_WORKSPACE)/src/app/api/api.js
	sed -i -e 's|var PRISM_VIRTUAL_HOST.*;|var PRISM_VIRTUAL_HOST = "prism_dev";|g' $(PROJECT_WORKSPACE)/src/app/api/api.js
	sed -i -e 's|base href="/"|base href="/portal/"|g' $(PROJECT_WORKSPACE)/src/index.html
	sed -i -e 's|S3_BUCKET|prism.portal|g' $(PROJECT_WORKSPACE)/build.config.js

	cd $(PROJECT_WORKSPACE) && yarn install --ignore-engines && grunt build

	cp -rf $(PROJECT_WORKSPACE)/portal $(DOCKER_WORKSPACE)/workspace
build: 
	@docker compose down
	@docker rmi ubuntu:prism-fe | echo ""
	@docker build -t ubuntu:prism-fe .

up: 
	@docker compose down
	@docker compose up -d
# @docker exec -it prism-fe /bin/bash -c "a2enmod rewrite headers proxy proxy_http lbmethod_byrequests"
# @docker exec -it prism-fe /bin/bash -c "/etc/init.d/apache2 start"

reload:
	docker exec -it prism-fe /bin/bash -c "/etc/init.d/apache2 reload"

restart:
	docker compose restart prism-fe

deploy: compress
	@docker compose down
	@docker rmi ubuntu:prism-fe | echo ""
	@docker build -t ubuntu:prism-fe .
	@docker compose up -d

test:
	cp -rf $(PROJECT_WORKSPACE)/portal $(DOCKER_WORKSPACE)/workspace
# rsync -av --exclude='portal' root@192.168.4.40:/var/www/prism-frontend .
