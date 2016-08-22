require 'ncurses'

Ncurses.initscr

Ncurses.mvaddstr(0, 0, "Hello, World!")

Ncurses.refresh

sleep(2)

Ncurses.endwin
