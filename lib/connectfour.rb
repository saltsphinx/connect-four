class ConnectFour
  def initialize
    @players = ['Red', 'Yellow']
    @current_player = @players.first
    @board
  end

  def play
    main_menu
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

  def player_turn

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