Runs consul-template and nginx in a single container. Reloads nginx automatically.

example usage:

```
	docker run -it --name nginx \
		-v $$(pwd)/config/services.ctmpl:/config/services.ctmpl \
		-v $$(pwd)/certs:/certs \
		-e CONSUL_URL="dev-consul:8500" \
		--link dev-consul -p 80:80 -p 443:443 quay.io/solohin_i/docker-nginx-consul-template
```


TODO:
+ Install and run consul-template
+ Set consul server as a ENV variable
+ Add consul-template to s6
+ Use templates instead of config
+ Reload nginx after config update
+ Add SSL certificate support