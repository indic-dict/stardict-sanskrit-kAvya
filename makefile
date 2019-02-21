STARDICT_TOOLS_DIR=~/stardict/tools/src/
STARDICT_SANSKRIT_BIN=~/stardict-sanskrit/bin

# make all DICTS=xyz
DICTS=.*

# Let the URL not end with /.
URL=https://github.com/indic-dict/stardict-sanskrit-kAvya/raw/master/tars


.PHONY: all stardict tars

all:final_babylon stardict tars

final_babylon:
	bash $(STARDICT_SANSKRIT_BIN)/babylon_add_optitrans.sh DICTS=$(DICTS)

stardict:
	bash $(STARDICT_SANSKRIT_BIN)/tsv_to_stardict.sh DICTS=$(DICTS)

tars:
	bash $(STARDICT_SANSKRIT_BIN)/make_tarballs.sh $(URL) DICTS=$(DICTS)

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))
tarlist:
	bash $(STARDICT_SANSKRIT_BIN)/update_tars_md.sh $(current_dir)tars $(URL)
