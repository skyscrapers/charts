CHARTS := $(shell find . -path '*/Chart.yaml' | tr '\n' ' ' | sed -E 's:\./|/Chart\.yaml::g')

.PHONY: all prep package index

all: prep package index

prep:
	mkdir -p charts
	wget -q https://skyscrapers.github.io/charts/index.yaml -O old-index.yaml

package:
	$(foreach chart,$(CHARTS),(helm package $(chart) -u -d ./charts) &&) :

index:
	@helm repo index ./charts --url https://skyscrapers.github.io/charts --merge old-index.yaml
