SHELL=/usr/bin/env bash
war_file="example" # UPDATE THIS!!!


# make will run the first task that doesn't start with a . as the default task
# meaning that no parameter was given
# therefore in this file, the default task will run if you simply run "make"
default: clean build deploy

build: build_java build_war

build_java:
	./scripts/build_java.sh

build_war:
	./scripts/build_war.sh ${war_file}

deploy:
	./scripts/deploy.sh ${war_file}

clean:
	./scripts/clean.sh ${war_file}

publish: clean build
	./scripts/publish.sh ${war_file}

# don't use this, it was a poc
config:
	./scripts/conf.sh
