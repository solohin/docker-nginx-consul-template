run: build
	docker rm -f nginx; true
	docker run -it --name nginx \
		-v $$(pwd)/config/services.ctmpl:/config/services.ctmpl \
		-e CONSUL_URL="dev-consul:8500" \
		--link dev-consul -p 80:80 quay.io/solohin_i/docker-nginx-consul-template

start-consul:
	docker rm -f dev-consul; true 
	docker run -d -p 8500:8500 -p 8300:8300 --name=dev-consul consul

build:
	docker build -t quay.io/solohin_i/docker-nginx-consul-template .

bash:
	docker exec -it nginx bash