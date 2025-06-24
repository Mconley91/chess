require './lib/board.rb'
require './lib/rules.rb'
require './lib/display.rb'

class Game 
  attr_accessor :game_board, :player_turn, :round, :turn
  
  def initialize
    @game_board = Board.new()
    @player_turn = 'White'
    @round = 1
    @turn = 0
    @selected_piece = nil
    @selected_square = nil
  end

  include Display

  def set_game
    @game_board.set_pieces
  end

  def handle_play
    loop do
      self.set_game
      self.display_game
      loop do
        self.set_select_piece(self.get_input)
        self.display_selected_piece
        break if @selected_piece
      end
      loop do
        self.select_square(self.get_input)
        break if @selected_square
      end
      self.execute_move
      #determine winner/draw here
      self.next_turn
    end
  end

  def get_input
    loop do
      input = gets.chomp.downcase.split('')
      return convert_to_yx(input) if play_validator(input)
    end
  end

  def convert_to_yx(input)
    yx = [nil,nil]
    yx[0] = 8 - input[1].to_i
    case input[0]
      when 'a' 
        yx[1] = 0
      when 'b' 
        yx[1] = 1
      when 'c' 
        yx[1] = 2
      when 'd' 
        yx[1] = 3
      when 'e' 
        yx[1] = 4
      when 'f' 
        yx[1] = 5
      when 'g' 
        yx[1] = 6
      when 'h' 
        yx[1] = 7
    end
    yx
  end

  def play_validator(play)
    return true if  %w"a b c d e f g h".any?(play[0]) && play[1].to_i.between?(1,8) && play.length == 2
    p 'invalid entry'
    false
  end

  def next_turn
    self.turn += 1
    if self.turn.even? then self.round += 1 end
    @player_turn = @player_turn == 'White' ? 'Black' : 'White'
  end

  def set_select_piece(yx)
    if @player_turn == 'White'
      @selected_piece = @game_board.white_pieces.find{|piece| piece.yx == yx}
    else
      @selected_piece = @game_board.black_pieces.find{|piece| piece.yx == yx}
    end
  end

  def select_square(yx)
    @selected_square = yx # square selection will be a little more complex later
  end

  def execute_move
    @game_board.squares[@selected_piece.yx[0]][@selected_piece.yx[1]] = '_'
    @selected_piece.yx = @selected_square
  end

end