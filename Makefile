# Makefile with some convenient quick ways to do common things

PROJECT=pyEOCFI
PYTHON=python
BASEDIR=./
LIBDIR=$(BASEDIR)/lib
SRCDIR=${BASEDIR}/src

INCEXT=-I$(BASEDIR)/external_libraries/EOCFI/V4.24/include/ \
		-I$(BASEDIR)/external_libraries/OSFI/include/osfi-cpp/ \
		-I${BASEDIR}/pyeocfi/common/cincude/ \
		-I${BASEDIR}/pyeocfi/data/cincude/ \
		-I${BASEDIR}/pyeocfi/lib/cincude/ \
		-I${BASEDIR}/pyeocfi/orbit/cincude/ \
		-I${BASEDIR}/pyeocfi/pointing/cincude/ \
		-I${BASEDIR}/pyeocfi/visability/cincude/ 
		

LIBEXT = -L$(BASEDIR)/external_libraries/EOCFI/lib/LINUX64/ \
			-L$(BASEDIR)/external_libraries/OSFI/build/ \

LDFLAGS= $(LIBEXT)  \
 				-lboost_filesystem \
				-lboost_system \
				-lboost_date_time \
				-losfi-common\
				-lexplorer_visibility \
				-lexplorer_pointing \
				-lexplorer_orbit \
				-lexplorer_lib \
				-lexplorer_data_handling \
				-lexplorer_file_handling \
				-lgeotiff \
				-ltiff \
				-lproj \
				-lxml2 \
				-lm \
				-lc \
				-lpthread \
				-lxerces-c \
				-lstdc++fs


DFLAGS=-fopenmp -shared

CFLAGS= -std=c++11 -W -Wall -Wformat -Wno-unused-parameter -shared -fPIC -ldl $(DFLAGS) $(INCEXT)

ifeq "$(MODE)" "DEBUG"
	CFLAGS += -g
else
	CFLAGS += -o3
endif

CC=g++

help:
	@echo ''
	@echo '$(PROJECT) available make targets:'
	@echo ''
	@echo '  help         Print this help message (the default)'
	@echo '  env          Create a conda environment for pyEOCFI'
	@echo '  clean        Remove temp files'
	@echo '  test         Run tests'
	@echo ''

init:
	@echo "Setting up EOCFI software"
	unzip ./external_libraries/EOCFI-4.26-CLIB-LINUX64.zip -d  ./external_libraries/EOCFI/ 
	mkdir ./external_libraries/OSFI/
	tar -xvf  ./external_libraries/osfi-3.9.2-sources.tar.xz -C ./external_libraries/OSFI/

clean:
	@echo "Need to specify targets to remove"
	$(RM) -rf ./external_libraries/EOCFI  ./external_libraries/OSFI
# 	$(RM) -rf build docs/_build docs/api htmlcov ctapipe.egg-info dist
# 	find . -name "*.pyc" -exec rm {} \;
# 	find . -name "*.so" -exec rm {} \;
# 	find . -name __pycache__ | xargs rm -fr

test:
	pytest

# doc:
# 	cd docs && $(MAKE) html SPHINXOPTS="-W --keep-going -n --color -j auto"
# 	@echo "------------------------------------------------"
# 	@echo "Documentation is in: docs/_build/html/index.html"

# doc-publish:
# 	ghp-import -n -p -m 'Update gh-pages docs' docs/_build/html

env:
	conda env create -n pyEOCFI -f environment.yml
	source activate pyEOCFI

develop:
	pip install -e .

# wheel:
# 	python -m build --wheel

# sdist:
# 	python -m build --sdist

# trailing-spaces:
# 	find $(PROJECT) examples docs -name "*.py" -exec perl -pi -e 's/[ \t]*$$//' {} \;


all: ${LIBDIR}/libpygmd.so


${LIBDIR}/libpygmd.so: ${SRCDIR}/pointing/eocfi_pointing.cpp ${SRCDIR}/orbit/eocfi_orbit.cpp ${SRCDIR}/library/eocfi_lib.cpp
	$(CC) -Wl,--whole-archive $(BASEDIR)/external_libraries/EOCFI/lib/LINUX64/libexplorer_pointing.a \
	$(BASEDIR)/external_libraries/EOCFI/lib/LINUX64/libexplorer_data_handling.a \
	$(BASEDIR)/external_libraries/EOCFI/lib/LINUX64/libexplorer_file_handling.a \
	$(BASEDIR)/external_libraries/EOCFI/lib/LINUX64/libexplorer_lib.a \
	$(BASEDIR)/external_libraries/EOCFI/lib/LINUX64/libexplorer_orbit.a \
	$(BASEDIR)/external_libraries/EOCFI/lib/LINUX64/libexplorer_visibility.a \
	$(BASEDIR)/external_libraries/EOCFI/lib/LINUX64/libproj.a \
	$(BASEDIR)/external_libraries/EOCFI/lib/LINUX64/libxml2.a \
	-Wl,--no-whole-archive ${LDFLAGS} ${CFLAGS} -o $@ $? -lc

