require 'ncurses'
require './back-end.rb'

# create a screen object
Ncurses.initscr

begin
  Ncurses.cbreak()
  # don't output what you type on the screen
  Ncurses.noecho()

  # don't show cursor
  Ncurses.curs_set(0)

  # 113 == 'q' in the ascii table
  while((ch = Ncurses.getch()) != 113) do
    case(ch.chr)
    when 'p'
    end
    
    Ncurses.refresh()
  end
ensure
  Ncurses.curs_set(1)
  Ncurses.endwin()
end
