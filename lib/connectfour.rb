require_relative './board'

class ConnectFour
  def initialize
    @players = ['Red', 'Yellow']
    @current_player = @players.first
    @board = Board.new
  end

  def play
    main_menu
    game_cycle
    game_ended
  end

  def user_input(min, max)
    loop do
      input = gets.chomp
      return input.to_i if input.match?(/^\d+$/) && input.to_i.between?(min, max)
      puts "Please enter a number between #{min} and #{max}"
    end
  end

  def main_menu
    splash
    option_select = user_input(1, 2)
    info if option_select == 2
  end

  def game_cycle
    until @board.game_end?
      @board.display_board
      player_turn
      rotate_player
      change_player
    end
  end

  def player_turn
    input = nil
    while input.nil?
      result = user_input(1, 7)
      if @board.columns[result - 1].size < 6
        input = result
      else
        puts "Column #{result} is full!"
      end
    end
    @board.insert(input - 1, @current_player)
  end
  
  def rotate_player
    @players.rotate!
  end

  def change_player
    @current_player = @players.first
  end

  def splash
    splash_text = "Connect Four\n\nOptions:\n1 - Play\n2 - Info"
    puts splash_text
  end

  def game_ended
    @board.display_board
    puts 'Game over!'
    puts "#{@board.winner} wins!"
  end

  def info
    info_text = "Connect four is played on a 6x7 board, where two players drop pieces into slots. Which ever player connects four pieces in a horizontial, vertical or diagonal wins."
    puts info_text
    prompt
    main_menu
  end

  def prompt
    prompt_text = "\nPress enter to continue"
    puts prompt_text
    gets
  end
end