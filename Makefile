# Primitive makefile for including just required files in the distribution.
# @requires jsmin (http://www.crockford.com/javascript/jsmin.html)
# @requires zip
FILES=index.html options.html profiles.html manifest.json
DIRS=images styles js fonts
DIST=dist

dist: clean copy minify pack

copy:
	@echo "### Copying files..."
	cp -R $(DIRS) $(FILES) $(DIST)

minify:
	@echo "### Minifying JS..."
	cat $(DIST)/js/engine.js | jsmin > $(DIST)/js/engine.min.js
	cat $(DIST)/js/index.js | jsmin > $(DIST)/js/index.min.js
	cat $(DIST)/js/options.js | jsmin > $(DIST)/js/options.min.js
	cat $(DIST)/js/profiles.js | jsmin > $(DIST)/js/profiles.min.js
	mv $(DIST)/js/engine.min.js $(DIST)/js/engine.js
	mv $(DIST)/js/index.min.js $(DIST)/js/index.js
	mv $(DIST)/js/options.min.js $(DIST)/js/options.js
	mv $(DIST)/js/profiles.min.js $(DIST)/js/profiles.js
	@echo "### Minifying CSS..."
	lessc -x $(DIST)/styles/index.css > $(DIST)/styles/index.min.css
	lessc -x $(DIST)/styles/options.css > $(DIST)/styles/options.min.css
	lessc -x $(DIST)/styles/normalize.css > $(DIST)/styles/normalize.min.css
	mv $(DIST)/styles/index.min.css $(DIST)/styles/index.css
	mv $(DIST)/styles/options.min.css $(DIST)/styles/options.css
	mv $(DIST)/styles/normalize.min.css $(DIST)/styles/normalize.css

pack:
	@echo "### Packing..."
	find $(DIST) -name '.DS_Store' | xargs rm
	cd $(DIST); zip -r dist.zip *

clean:
	rm -rf $(DIST)/*
