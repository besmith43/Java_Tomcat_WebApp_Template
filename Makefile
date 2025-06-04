SHELL=/usr/bin/env bash
war_file="example"
ssh_server="web"

# make will run the first task that doesn't start with a . as the default task
# meaning that no parameter was given
# therefore in this file, the default task will run if you simply run "make"
default: deploy

build: clean build_java build_war

build_java:
	./scripts/build_java.sh

build_war:
	./scripts/build_war.sh ${war_file}

full_deploy: deploy deploy_db

deploy: build
	./scripts/deploy.sh ${war_file}

deploy_db:
	./scripts/deploy_db.sh ${war_file}

clean:
	./scripts/clean.sh ${war_file}

full_publish: publish publish_db

publish: build
	./scripts/publish.sh ${war_file} ${ssh_server}

publish_db:
	./scripts/publish_db.sh ${war_file} ${ssh_server}

logs: clean_logs
	./scripts/get_logs.sh ${ssh_server}

clean_logs:
	./scripts/clean_logs.sh

# don't use this, it was a poc
config:
	./scripts/conf.sh
