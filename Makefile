run: build
	docker rm -f nginx; true
	docker run -it --name nginx -v $$(pwd)/config:/config -p 80 dimaj/nginx

build:
	docker build -t dimaj/nginx .