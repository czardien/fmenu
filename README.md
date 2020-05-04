# fzf + dmenu = :heart:

The title is deceiptively misleading as this application is not a dmenu per se although it's based on it. Largely inspired from [fzf's wiki examples](https://github.com/junegunn/fzf/wiki/examples#fzf-as-dmenu-replacement).

## Installation

Depends on: [`fzf`](https://github.com/junegunn/fzf), [`st`](https://st.suckless.org/), and [Hack font](https://github.com/source-foundry/Hack) for some reason.

Clone the repo anywhere then proceed; installation will create the directory: `$HOME/.fmenu` and create the symbolic link: `$HOME/.local/bin/fmenu -> $(cloned repo)/fmenu.sh`.

Run:

```
make build
```

## Usage

```
fmenu
```

List all menu entries:

```
fmenu ls
```

Add a menu entry:

```
fmenu add firefox
```

Remove a menu entry:

```
fmenu rm firefox
```
