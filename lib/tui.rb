require 'ncurses'
require './back_end.rb'

# create a new backend from the backend class
@back_end = BackEnd.new

# create a screen object
Ncurses.initscr

# method to write currently playing song
def write_currently_playing
  Ncurses.mvaddstr(Ncurses.getmaxy(Ncurses.stdscr) - 1,
                   0, @back_end.get_current_song)
  Ncurses.refresh
  sleep(1)
end

begin
  Ncurses.cbreak()
  # don't output what you type on the screen
  Ncurses.noecho()

  # don't show cursor
  Ncurses.curs_set(0)
 
  write_currently_playing

  Thread.new{ write_currently_playing }  

  # 113 == 'q' in the ascii table
  while((ch = Ncurses.getch()) != 113) do
    case(ch.chr)
    when 'p'
    end

    Ncurses.refresh()
  end
ensure
  # disconnect from mopidy
  @back_end.disconnect
  Ncurses.curs_set(1)
  Ncurses.endwin()
end
