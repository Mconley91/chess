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
  end

  include Display

  def set_game
    @game_board.set_pieces
  end

  def handle_play
    loop do
      self.display_game
      # returns a valid coordinate input for use in selecting & playing pieces
      self.get_input
      #selecting and moving a piece will be a 2 step process
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
    yx[0] = input[1].to_i - 1 
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

  def select_piece(yx)
    
  end

end