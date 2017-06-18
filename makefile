STARDICT_TOOLS_DIR=~/stardict/tools/src/
STARDICT_SANSKRIT_BIN=~/stardict-sanskrit/bin

# make all DICTS=xyz
DICTS=.*

# Let the URL not end with /.
URL=https://github.com/sanskrit-coders/stardict-sanskrit/raw/master/$(shell pwd|sed -e s/.*[/]//)/tars


.PHONY: all stardict tars

all:final_babylon stardict tars

final_babylon:
	bash ../bin/babylon_add_optitrans.sh DICTS=$(DICTS)

stardict:
	bash ../bin/tsv_to_stardict.sh DICTS=$(DICTS)
	
tars:
	bash ../bin/make_tarballs.sh $(URL) DICTS=$(DICTS)

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))
tarlist:
	bash ../bin/update_tars_md.sh $(current_dir)tars $(URL)


