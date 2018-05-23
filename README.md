# termsuite-docker-omtd


A docker project for:
 - building a TermSuite (v3.0.10) docker image including its 3rd-party dependencies (TreeTagger v3.2.1),
 - running TermSuite tools added to OpenMinted platform as Components.

# Building TermSuite docker image

1. Clone this docker project:

```
$ git clone https://github.com/VisaTM/termsuite-docker-omtd.git
```

2. Build the docker image:

```
$ cd termsuite-docker-omtd
```
If Behind a proxy:
```
$ docker build --build-arg http_proxy="$http_proxy" --build-arg https_proxy="$https_proxy" --build-arg no_proxy="$no_proxy" -t visatm/termsuite-omtd:latest .
```
If not:
```
$ docker build --rm -t visatm/termsuite-omtd:latest .
```

# Running TermSuite

Once the image is built you can run TermSuite tools with OMTD-Galaxy like commands. Usage:

```
termsuite fr.univnantes.termsuite.tools.{PreprocessorCLI | TerminologyExtractorCLI | AlignerCLI}
```


There are currently three TermSuite tools available with the docker images:


 1. `termsuite fr.univnantes.termsuite.tools.PreprocessorCLI` applies TermSuite preprocessing to documents).

OMTD-Galaxy like command:

```
docker run --rm -it -v $PWD/termsuite:/opt/termsuite \
-v /path/to/input/corpus:/path/to/input/corpus \
-v /path/to/output/corpus:/path/to/output/corpus \
-w /path/to/output/corpus \
--name termsuite-omtd \
visatm/termsuite-omtd termsuite fr.univnantes.termsuite.tools.PreprocessorCLI \
--input /path/to/input/corpus \
--output /path/to/output/corpus \
--param:language=en
```

 1. `termsuite fr.univnantes.termsuite.tools.TerminologyExtractorCLI` extracts terminologies from a domain-specific corpus.

OMTD-Galaxy like command:

```
docker run --rm -it -v $PWD/termsuite:/opt/termsuite \
-v /path/to/input/corpus:/path/to/input/corpus \
-v /path/to/output/corpus:/path/to/output/corpus \
-w /path/to/output/corpus \
--name termsuite-omtd \
visatm/termsuite-omtd termsuite fr.univnantes.termsuite.tools.TerminologyExtractorCLI \
--input /path/to/input/corpus \
--output /path/to/output/corpus \
--param:language=en
```

You can add optional parameters:
```
--param:disable-gathering=false \
--param:post-filter-top-n=60
```

 1. `termsuite fr.univnantes.termsuite.tools.AlignerCLI` runs bilingual aligners.

OMTD-Galaxy like command:

```
docker run --rm -it -v $PWD/termsuite:/opt/termsuite \
-v /path/to/input/file:/path/to/input/file \
-v /path/to/output/file:/path/to/output/file \
-w /path/to/output/file \
--name termsuite-omtd \
visatm/termsuite-omtd termsuite fr.univnantes.termsuite.tools.AlignerCLI \
--input /path/to/input/file \
--output /path/to/output/file \
--param:source-termino=targetTermino.?
--param:target-termino=sourceTermino.?
--param:dictionary=dictionary.?
--param:tsv=AlignerResult.tsv
```

See TermSuite [Command Line API documentation](https://termsuite.github.io/documentation/command-line-api/) to get details on possible parameters for each of these programs.


# Pushing Termsuite-omtd docker image

You need first to connect to DockerHub with your credentials (see [docs](https://docs.docker.com/engine/reference/commandline/login/) ):
```
$ docker login --username mhabsaoui  --password-stdin
```

Then push the built docker image to DockerHub
```
$ docker push visatm/termsuite-omtd:latest
```
