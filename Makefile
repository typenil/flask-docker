
### Edit these variables ###
IMG_NAME=flask-composed
PORT=80
TAG=latest
### End of edit ###

IMG=typenil/$(IMG_NAME)
CONTAINER=$(IMG_NAME)
RUNOPTS=-p $(PORT):80
FQ_IMG?=$(IMG):$(TAG)

SERVICE=web

pull:
	docker-compose pull

push:
	docker-compose push

build:
	docker-compose build

run:
	docker-compose up -d

restart:
	docker-compose restart

create_db:
	docker-compose run api /usr/local/bin/python src/db/create_db.py

rm:
	docker-compose rm -f

logs:
	docker-compose logs

envs:
	docker-compose run $(SERVICE) env

enter:
	docker-compose run $(SERVICE) bash

test:
	docker-compose run api bash -c "py.test test/"

code-coverage:
	docker-compose run api bash -c "py.test --cov=src test/"

travis-coverage:
	docker-compose run api bash -c "py.test --cov-report xml --cov=src test/"
	docker-compose run api bash -c "cat coverage.xml" | tee api/coverage.xml