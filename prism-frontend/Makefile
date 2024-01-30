PROJECT_WORKSPACE:= ~/data/bluebottle/prism/prism-frontend
DOCKER_WORKSPACE:= ~/data/docker/prism-frontend
BACKEND_API:=https://test.prism.horse/api
WS_API:=ws://rabbitmq:15674/ws

compress:
	
	rm -rf $(PROJECT_WORKSPACE)/portal | echo ""
	rm -rf $(DOCKER_WORKSPACE)/portal | echo ""
	
	sed -i -e 's|var PRISM_API_URL.*;|var PRISM_API_URL = "$(BACKEND_API)";|g' $(PROJECT_WORKSPACE)/src/app/api/api.js
	sed -i -e 's|var PRISM_STOMP_URL.*;|var PRISM_STOMP_URL = "$(WS_API)";|g' $(PROJECT_WORKSPACE)/src/app/api/api.js
# @sed -i -e 's/var PRISM_VIRTUAL_HOST.*;/var PRISM_VIRTUAL_HOST = "prism_test";/g' src/app/api/api.js
	
	cd $(PROJECT_WORKSPACE) && npm cache verify && bower install -E && grunt build

	cp -rf $(PROJECT_WORKSPACE)/portal $(DOCKER_WORKSPACE)/

build: 
	@docker build -t httpd:prism-frontend . --no-cache

up: 
	@docker compose down
	@docker compose up -d
	@docker compose logs -f

test:
	