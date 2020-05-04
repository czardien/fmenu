#!/usr/bin/env sh
function _fmenu() {
	input=$(mktemp -u --suffix .fzfmenu.input)
	output=$(mktemp -u --suffix .fzfmenu.output)
	mkfifo $input
	mkfifo $output
	chmod 600 $input $output

	st -f "Hack:size=12" -c fzfmenu -n fzfmenu -e sh -c "cat $input | fzf --height=100% --border=sharp $* | tee $output" & disown
	trap "kill $! 2>/dev/null; rm -f $input $output" EXIT

	ls $FMENU/ > $input
	$(cat $output)
}

function _add() {
	[[ -z "$1" ]] && (echo "fatal: needs to pass a binary argument")
	bin="$1"
	loc="$(which "$bin")" || (echo "fatal: binary: $bin not found in \$PATH; are you sure you installed that right?"; exit 1)
	[[ $? == 0 ]] && ln -sf $loc $FMENU/$bin && echo "Successfully added menu entry: $bin with location: $loc"
}

function _rm() {
	[[ -z "$1" ]] && (echo "fatal: needs to pass a binary argument")
	bin="$1"
	[[ -f $FMENU/$bin ]] && rm $FMENU/$bin && \
		echo "Successfully removed entry: $bin from menu"|| \
		(echo "fatal: didn't find entry to delete: $bin in: $FMENU/"; exit 1)
}

function _ls() {
	bin="$1"
	found="$(find $FMENU/$bin -type l -ls | awk '{printf "%s %s %s\n", $11, $12, $13}')"
	[[ -z "$found" ]] && echo -e "No menu entry found!\nUse \`fmenu add <application>\`" || \
		echo -e "$found"
}

FMENU=$HOME/.fmenu
[[ -d $FMENU ]] || mkdir -p $FMENU

allowed="fmenu add rm ls"
verb=$1

if [[ $# == 0 ]]
then
	verb=fmenu
fi

[[ $allowed =~ (^| )$verb($| ) ]] || (echo -e 'fatal: action not allowed'; exit 1)

if [[ "$verb" == "fmenu" ]]; then _fmenu; fi
if [[ "$verb" == "add" ]]; then _add $2; fi
if [[ "$verb" == "rm" ]]; then _rm $2; fi
if [[ "$verb" == "ls" ]]; then _ls $2; fi
