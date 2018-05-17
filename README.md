# termsuite-docker-omtd


A docker project for:
 - building a TermSuite (v3.0.10) docker image including its 3rd-party dependencies (TreeTagger v3.2.1),
 - running TermSuite tools added to OpenMinted platform as Components.

# Building TermSuite docker image

1. Clone this docker project:

```
$ git clone https://github.com/termsuite/termsuite-docker-omtd.git
```

2. Build the docker image:

```
$ cd termsuite-docker-omtd
$ docker build --rm -t visatm/termsuite-omtd:latest .
```
If Behind a proxy:
```
$ docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} --build-arg no_proxy=${no_proxy} -t visatm/termsuite-omtd:latest .
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
-v /path/to/corpusInput:/path/to/corpusInput \
-v /path/to/corpusOutput:/path/to/corpusOutput \
-w /path/to/corpusOutput \
--name termsuite-omtd \
visatm/termsuite-omtd termsuite fr.univnantes.termsuite.tools.PreprocessorCLI \
--input /path/to/corpusInput \
--output /path/to/corpusOutput \
--param:language=en
```

 1. `termsuite fr.univnantes.termsuite.tools.TerminologyExtractorCLI` extracts terminologies from a domain-specific corpus.

OMTD-Galaxy like command:

```
docker run --rm -it -v $PWD/termsuite:/opt/termsuite \
-v /path/to/corpusInput:/path/to/corpusInput \
-v /path/to/corpusOutput:/path/to/corpusOutput \
-w /path/to/corpusOutput \
--name termsuite-omtd \
visatm/termsuite-omtd termsuite fr.univnantes.termsuite.tools.TerminologyExtractorCLI \
--input /path/to/corpusInput \
--output /path/to/corpusOutput \
--param:language=en
```

 1. `termsuite fr.univnantes.termsuite.tools.AlignerCLI` runs bilingual aligners.

OMTD-Galaxy like command:

```
docker run --rm -it -v $PWD/termsuite:/opt/termsuite \
-v /path/to/fileInput:/path/to/fileInput \
-v /path/to/fileOutput:/path/to/fileOutput \
-w /path/to/fileOutput \
--name termsuite-omtd \
visatm/termsuite-omtd termsuite fr.univnantes.termsuite.tools.AlignerCLI \
--input /path/to/fileInput \
--output /path/to/fileOutput \
--param:source-termino=targetTermino.?
--param:target-termino=sourceTermino.?
--param:dictionary=dictionary.?
--param:tsv=AlignerResult.tsv
```

See TermSuite [Command Line API documentation](https://termsuite.github.io/documentation/command-line-api/) to get details on possible parameters for each of these programs.
