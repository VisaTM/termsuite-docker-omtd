FROM openjdk:8-jre

LABEL maintainer="Stephane Schneider <Stephane.SCHNEIDER@inist.fr>"

ENV \
  TT_VERSION=3.2.2 \
  TERMSUITE_VERSION=3.0.10 \
  TT_URL=http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data

RUN mkdir -p /opt/treetagger/
WORKDIR /opt/treetagger/
RUN wget ${TT_URL}/tree-tagger-linux-${TT_VERSION}.tar.gz \
    && wget ${TT_URL}/tagger-scripts.tar.gz \
    && wget ${TT_URL}/english.par.gz \
    && wget ${TT_URL}/french.par.gz \
    && wget ${TT_URL}/german.par.gz \
    && wget ${TT_URL}/russian.par.gz \
    && wget ${TT_URL}/italian.par.gz \
    && wget ${TT_URL}/spanish.par.gz \
    && wget ${TT_URL}/install-tagger.sh \
    && sh /opt/treetagger/install-tagger.sh \
    && mv lib models \
    && rm -rf *.gz *.tgz cmd/ doc/

WORKDIR /opt/treetagger/models/
RUN  chmod a+x /opt/treetagger/models/

WORKDIR /opt/
# RUN  curl -O -L https://search.maven.org/remotecontent?filepath=fr/univ-nantes/termsuite/termsuite-core/${TERMSUITE_VERSION}/termsuite-core-${TERMSUITE_VERSION}.jar
COPY  ./src/termsuite-core-omtd-3.0.10.jar /opt/

COPY ./src/termsuite /opt/
RUN chmod a+x /opt/termsuite

ENV PATH /opt:$PATH

RUN apt-get purge -y --auto-remove
