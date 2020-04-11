Runs consul-template and nginx in a single container. Reloads nginx automatically.

example usage:

```
docker run -it --name nginx-consul-template \
    -v $(pwd)/templates:/templates \
    -v $(pwd)/ssl:/ssl \
    solohin/docker-nginx-consul-template
```


TODO:
+ Install and run consul-template
- Set consul server as a ENV variable
- Add consul-template to s6
- Use templates instead of config
- Reload nginx after config update
- Add SSL certificate support