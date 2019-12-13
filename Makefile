
all: help

.PHONY: help # Help info.
help:
	@grep '^.PHONY:.*' Makefile | sed 's/\.PHONY:[ \t]\+\(.*\)[ \t]\+#[ \t]*\(.*\)/\1	\2/' | expand -t20


.PHONY: up # Build and up thumbor services using docker-compose.
up:
	test -f env || cp env.template env
	docker-compose up --build -d nginx


.PHONY: run-tests # Run tests using pytest and docker-compose service definition.
run-tests:
	echo "Running tests..."
	pytest
	echo "Tests done"


.PHONY: builds # Build images using docker-compose image tags.
builds:
	echo "Building thumbor images..."
	docker-compose -f docker-compose-travis.yml build
	echo "Building done"


.PHONY: tags # Tagging images by version THUMBOR_VERSION.
tags:
	echo "Tagging images using '$${THUMBOR_VERSION}' version..."
	docker tag apsl/thumbor:build-base apsl/thumbor:base-$${THUMBOR_VERSION}
	docker tag apsl/thumbor:build-full apsl/thumbor:full-$${THUMBOR_VERSION}
	docker tag apsl/thumbor:build-multiprocess-base apsl/thumbor:multiprocess-base-$${THUMBOR_VERSION}	
	docker tag apsl/thumbor:build-multiprocess-full apsl/thumbor:multiprocess-full-$${THUMBOR_VERSION}	
	docker tag apsl/thumbor:nginx-build apsl/thumbor:nginx-$${THUMBOR_VERSION}


.PHONY: tags-master # Tagging images by version latest.
tags-master:
	echo "Tagging images using 'latest' version..."
	test "$${TRAVIS_BRANCH}" = "master" && docker tag apsl/thumbor:build apsl/thumbor:latest || true
	test "$${TRAVIS_BRANCH}" = "master" && docker tag apsl/thumbor:build apsl/thumbor:nginx-latest || true
	echo "Tagging done"


.PHONY: push # Push images to the registry.
push:
	echo "Pushing images to the registry..."
	docker push apsl/thumbor:base-$${THUMBOR_VERSION}
	docker push apsl/thumbor:full-$${THUMBOR_VERSION}
	docker push apsl/thumbor:multiprocess-base-$${THUMBOR_VERSION}
	docker push apsl/thumbor:multiprocess-full-$${THUMBOR_VERSION}
	docker push apsl/thumbor:nginx-$${THUMBOR_VERSION}
	echo "Pushed"

#.PHONY: push-master # Push latest images to the registry.
#push-master:
#	echo "Pushing images to the registry..."
#	test "$${TRAVIS_BRANCH}" = "master" && docker tag apsl/thumbor:build apsl/thumbor:latest || true
#	test "$${TRAVIS_BRANCH}" = "master" && docker tag apsl/thumbor:build apsl/thumbor:nginx-latest || true
#	echo "Pushed"
