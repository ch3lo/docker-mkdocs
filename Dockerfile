FROM alpine:latest
MAINTAINER Marcelo Salazar <chelosalazar@gmail.com>

RUN apk add --update \
  build-base \
  py-pip \
  python-dev && \
  rm -rf /var/cache/apk/*

RUN pip install mkdocs plantuml markdown-checklist

ADD https://raw.githubusercontent.com/ch3lo/markdown-plantuml/master/mdx_plantuml.py /usr/lib/python2.7/site-packages/markdown/extensions/
ADD https://raw.githubusercontent.com/teoric/python-markdown-yaml-meta-data/master/meta_yaml.py /usr/lib/python2.7/site-packages/markdown/extensions/

RUN adduser -H -D web

RUN mkdir /var/mkdocs && \
	chown web:web /var/mkdocs && \
	chmod +r -R /usr/lib/python2.7/site-packages/markdown/extensions/

USER web

VOLUME /var/mkdocs
WORKDIR /var/mkdocs

EXPOSE 8000

CMD ["mkdocs", "build"]
