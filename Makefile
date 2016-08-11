
lint:
	./node_modules/.bin/jshint ./test ./index.js ./lib/stan.js

test:
	@NODE_ENV=test ./node_modules/.bin/mocha -c\
	  --reporter list \
	  --slow 5000 \
	  --timeout 10000

test-cov:
	@NODE_ENV=test ./node_modules/.bin/istanbul cover \
	_mocha -- -R spec --slow 5000

test-coveralls:
	echo TRAVIS_JOB_ID $(TRAVIS_JOB_ID)
	$(MAKE) lint
	$(MAKE) test

	@NODE_ENV=test ./node_modules/.bin/istanbul cover \
	./node_modules/mocha/bin/_mocha --report lcovonly -- -R spec --slow 5000 && \
	  cat ./reports/coverage/lcov.info | ./node_modules/coveralls/bin/coveralls.js || true

.PHONY: test
