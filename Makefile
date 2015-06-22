IMAGE_NAME=ch3lo/mkdocs
TIME=$(shell date +%g%m%d%H%M)
IMAGE_NAME_WITH_TAG=$(IMAGE_NAME):$(TIME)


build:
	@echo "Building image"
	docker build --pull -t $(IMAGE_NAME_WITH_TAG) .
	docker tag -f $(IMAGE_NAME_WITH_TAG) $(IMAGE_NAME):latest

publish: build
	docker push $(IMAGE_NAME_WITH_TAG)
	docker push $(IMAGE_NAME):latest

bash:
	docker run -ti --rm $(IMAGE_NAME):latest sh

run:
	docker run --rm -P $(IMAGE_NAME):latest
