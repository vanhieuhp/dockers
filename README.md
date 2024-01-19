# Docker tool

1. remove docker image <none> tag:
```
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
```