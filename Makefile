
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
TEST_REGEX=*test.py

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

test: build
	docker-compose run $(SERVICE) bash -c "/usr/local/bin/python -m unittest discover --pattern $(TEST_REGEX)"
