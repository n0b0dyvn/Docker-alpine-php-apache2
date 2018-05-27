IMG=n0b0dyvn/php-apache-alpine:0.1
TEST_NAME=php-test
PORT=8081
CUR_DIR=/home/sangvh/Project/php-apache/
DIR=htdocs

build:
	rm -f ${CUR_DIR}/ssh-key/*
	ssh-keygen -t rsa -N "" -f ${CUR_DIR}/ssh-key/id_rsa
	docker build -t ${IMG} .

test:
	docker run -p ${PORT}:80 -p 2222:22 -v ${CUR_DIR}/${DIR}:/var/www/localhost/htdocs/ --name ${TEST_NAME} ${IMG}

clean:
	docker rm -f ${TEST_NAME}

testall:
	make build && \
	make test && \
	make clean