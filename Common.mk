PACKAGE_NAME ?= confluent-cli
VERSION ?= 3.4.0-SNAPSHOT

.PHONY:

all: build

install: build
ifndef CONFLUENT_HOME
	$(error Cannot install. CONFLUENT_HOME is not set)
endif
	install -D -m 755 bin/confluent $(CONFLUENT_HOME)/bin/confluent

build: oss

prep:
	mkdir -p bin/

oss: prep
	cp -f src/oss/confluent.sh bin/confluent
	chmod 755 bin/confluent

platform: prep
	cp -f src/platform/confluent.sh bin/confluent
	chmod 755 bin/confluent

clean:
	rm -rf bin/

distclean: clean

archive:
	git archive --prefix=$(PACKAGE_NAME)-$(VERSION)/ \
		-o $(PACKAGE_NAME)-$(VERSION).tar.gz HEAD
	git archive --prefix=$(PACKAGE_NAME)-$(VERSION)/ \
		-o $(PACKAGE_NAME)-$(VERSION).zip HEAD
