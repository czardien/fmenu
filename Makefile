build:
	chmod +x ./fmenu.sh
	mkdir -p $(HOME)/.fmenu
	ln -sf $(PWD)/fmenu.sh $(HOME)/.local/bin/fmenu

all: build
