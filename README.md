# termsuite-docker-omtd

TermSuite-docker adapted to OpenMinted platform as docker Components. A docker project for:

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
If not, simply:
```
$ docker build --rm -t visatm/termsuite-omtd:latest .
```

# Running TermSuite

Once the image is built you can run TermSuite tools with OMTD-Galaxy like commands. Usage:

```
termsuite fr.univnantes.termsuite.tools.{PreprocessorCLI | TerminologyExtractorCLI | AlignerCLI}
```


There are currently three TermSuite components available within the docker image:


 - `termsuite fr.univnantes.termsuite.tools.PreprocessorCLI` applies TermSuite preprocessing to documents. This component now supports also Xmi format corpus as input, and has been preset to produce only Xmi output corpus having all spotted term annotations (--xmi-anno). For more details, see TermSuite [Command Line API documentation](http://termsuite.github.io/documentation/preprocessor-cli/).

OMTD-Galaxy like command:

```
docker run --rm -it \
-v /path/to/input/corpus:/path/to/input/corpus \
-v /path/to/output/corpus:/path/to/output/corpus \
-w /path/to/output/corpus \
--name termsuite-omtd \
visatm/termsuite-omtd termsuite fr.univnantes.termsuite.tools.PreprocessorCLI \
--input /path/to/input/corpus \
--output /path/to/output/corpus \
--param:language=en
```

 - `termsuite fr.univnantes.termsuite.tools.TerminologyExtractorCLI` extracts terminologies from a domain-specific corpus. This component has been preset to consume only XMI format corpus (--from-prepared-corpus) and to output terminology to JSON file "TerminologyExtractor.json". For more details, see TermSuite [Command Line API documentation](http://termsuite.github.io/documentation/terminology-extractor-cli/).

OMTD-Galaxy like command:

```
docker run --rm -it \
-v /path/to/input/corpus:/path/to/input/corpus \
-v /path/to/output/corpus:/path/to/output/corpus \
-w /path/to/output/corpus \
--name termsuite-omtd \
visatm/termsuite-omtd termsuite fr.univnantes.termsuite.tools.TerminologyExtractorCLI \
--input /path/to/input/corpus \
--output /path/to/output/corpus \
--param:language=en
```

You can add those optional parameters (one of them or both):
```
--param:disable_gathering=true \
--param:post_filter_top_n=60
```

 - `termsuite fr.univnantes.termsuite.tools.AlignerCLI` runs bilingual aligners (WIP because of ancilary resources not being uploadable/exploitable on OMTD). For more details, see TermSuite [Command Line API documentation](http://termsuite.github.io/documentation/aligner-cli/).

OMTD-Galaxy like command:

```
docker run --rm -it \
-v /path/to/input/file:/path/to/input/file \
-v /path/to/output/file:/path/to/output/file \
-w /path/to/output/file \
--name termsuite-omtd \
visatm/termsuite-omtd termsuite fr.univnantes.termsuite.tools.AlignerCLI \
--input /path/to/input/file \
--output /path/to/output/file \
--param:source_termino=targetTermino.?
--param:target_termino=sourceTermino.?
--param:dictionary=dictionary.?
--param:tsv=AlignerResult.tsv
```

#### N.B. :
You can test your multiple modifications of the 'src/termsuite' script without having to rebuild the docker image each time. Besides, info logs have been added to control executed CLI commands and debug logs are to be decommented if needed. For that you need to add this mount:
```
-v $PWD/src/termsuite:/opt/termsuite
```

See TermSuite [Command Line API documentation](https://termsuite.github.io/documentation/command-line-api/) to get details on possible parameters for each of these programs.


# Pushing Termsuite-omtd docker image

You need first to connect to DockerHub with your credentials (see [docs](https://docs.docker.com/engine/reference/commandline/login/) ):
```
$ docker login --username <myDockerhubUserName>
```

Then push the built docker image to DockerHub
```
$ docker push visatm/termsuite-omtd:latest
```
