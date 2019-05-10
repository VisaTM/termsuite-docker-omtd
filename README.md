

# Installation du docker termsuite comme  outil complémentaire dans galaxy_tools

    cd $HOME/galaxy_tools
   

1. Clone this docker project:

```
$ git clone http://vsgit.intra.inist.fr:60000/git/VisaTM/termsuite-visatm-docker.git
```

2. Build the docker image:

```
$ cd termsuite-docker-omtd
```
```
$ docker build --build-arg http_proxy="$http_proxy" --build-arg https_proxy="$https_proxy" --build-arg no_proxy="$no_proxy" -t visatm/termsuite:latest .
```
