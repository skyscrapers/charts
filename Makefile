CHARTS := $(shell find . -path '*/Chart.yaml' | tr '\n' ' ' | sed -E 's:\./|/Chart\.yaml::g')

.PHONY: all prep package index post clean

all: prep package index post

prep:
	@mkdir -p charts
	@git checkout -B gh-pages

package:
	$(foreach chart,$(CHARTS),(helm package $(chart) -d ./charts --save=false) &&) :

index:
	@helm repo index ./charts --url https://skyscrapers.github.io/charts/charts
	@mv ./charts/index.yaml index.yaml

post:
	@git add --force charts index.yaml
	@git commit -m "Update Charts"
	@git checkout master
	echo "gh-pages branch is ready to push. git push --force origin gh-pages"

clean:
	@rm -rf charts
