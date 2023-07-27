#!/bin/sh

case "$1" in
*.tar*) tar tf "$1" ;;
*.zip) unzip -l "$1" ;;
*.rar) unrar l "$1" ;;
*.7z) 7z l "$1" ;;
*.pdf) pdftotext "$1" - ;;
*.md) mdcat "$1" ;;
*.jpg | *.jpeg | *.png | *.gif) kitty +kitten icat $1 ;;
*.go) nvim --clean "$1" ;;
*) bat --color=always --line-range=:500 --theme=OneHalfDark "$1" ;;
esac
