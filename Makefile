.PHONY: test
test:
	echo "TODO"

.PHONY: package
package:
	./scripts/package.sh

.PHONY: clean
clean:
	rm -rf build/*
