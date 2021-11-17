require_relative '../lib/connectfour'

describe ConnectFour do
  describe '#user_input' do
    #Looping script method, comfirm that the loop ends| Two parameters: min, max| Gets user's input, calles #verify_input
    #and checks that input only includes digits, prints to console if input is rejected|
    #handles all user input getting| depedencies: #verify_input, #gets
    subject(:game_input) { described_class.new }

    context 'when min and max are 1 and 6, and input is valid' do
      before do
        allow(game_input).to receive(:puts)  
      end

      it 'returns 3' do
        allow(game_input).to receive(:gets).and_return('3')
        expect(game_input.user_input(1, 6)).to eq(3)
      end

      it 'returns 6' do
        allow(game_input).to receive(:gets).and_return('6')
        expect(game_input.user_input(1, 6)).to eq(6)
      end
    end

    context 'when min and max are 1 and 6 and input is invalid then valid' do
      it 'puts error message' do
        min = 1
        max = 6
        
        allow(game_input).to receive(:gets).and_return('8', '5')
        error_message = "Please enter a number between #{min} and #{max}"
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.user_input(1, 6)
      end
    end
  end

  describe '#player_turn' do
    #Looping script method and outgoing command, test that error isn't sent to puts and that objects receieve message| It tells player its their turn, it calls #user_input(1, 6)
    #and stores the return to column variable, it calls #space?(column) to see if column has space and calls #game_move(column) if it does, and it
    #loops if the column is full| no parameters
    subject(:game_turn) { described_class.new }
    let(:board) { double('game_board') }

    context 'when column isn\'t full' do

    end
  end

  describe '#rotate_player' do
    #Command method, test that @current_player is changed| Changes current player by rotating @players array and changing @current player to first item|
    #No parameters
    subject(:rotate_game) { described_class.new }

    context 'when @players is ["Red", "Yellow"]' do
      it 'rotates @players array' do
        correct_array = ['Yellow', 'Red']
        rotate_game.rotate_player
        expect(rotate_game.instance_variable_get(:@players)).to eq(correct_array)
      end
    end
  end

  describe '#change_player' do
    #Command method, test that @cuerrent_player is changed
    subject(:game_player) { described_class.new }
    context 'when current player is red and #rotate_player is called' do
      it 'changes to yellow' do
        game_player.rotate_player
        game_player.change_player
        expect(game_player.instance_variable_get(:@current_player)).to eq('Yellow')
      end
    end
  end
end
