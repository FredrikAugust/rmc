# `rmc` - Ruby Music Client

[![asciicast](https://asciinema.org/a/4r9onc2inom7lnb8aratn69tr.png)](https://asciinema.org/a/4r9onc2inom7lnb8aratn69tr)

## Usage

`j` or `up` navigate up

`k` or `down` navigate down

`<space>` or `p` pause/unpause

`<enter>` play

`-` volume down by 5%

`+` volume up by 5%

`>` next song

`<` previous song

## Running

`cd rmc/lib/`

`ruby tui.rb`

## Dependencies

* `mopidy` this has to run on `localhost` port `6600` unless you wanna change that manually. You can do that in the `back_end.rb` file
* `ruby >=2.0`
* `ncurses-ruby`
* `ruby-mpd`
