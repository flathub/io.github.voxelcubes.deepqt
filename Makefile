.PHONY: all generate-dependencies build bundle install

all: generate-dependencies build bundle install

ID := io.github.voxelcubes.deepqt


generate-dependencies:
	python flatpak-builder-tools/pip/flatpak-pip-generator --runtime='org.kde.Sdk//6.10' --yaml --output pypi-dependencies --requirements-file='requirements.txt'

build-install:
	flatpak run org.flatpak.Builder --force-clean --sandbox --user --install --install-deps-from=flathub --ccache --mirror-screenshots-url=https://dl.flathub.org/repo/screenshots --repo=repo builddir $(ID).yaml

run:
	flatpak run $(ID)

lint:
	flatpak run --command=flatpak-builder-lint org.flatpak.Builder manifest $(ID).yaml
	flatpak run --command=flatpak-builder-lint org.flatpak.Builder --exceptions repo repo

clean:
	rm -rf builddir repo deepqt.flatpak .flatpak-builder

introspect:
	flatpak run --command=sh --devel $(ID)


