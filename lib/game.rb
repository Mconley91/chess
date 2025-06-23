require './lib/board.rb'
require './lib/rules.rb'
require './lib/display.rb'

class Game 
  attr_accessor :game_board
  
  def initialize
    @game_board = Board.new()
    @turn = 'white'
  end

  include Display

  def set_game
    @game_board.set_pieces
  end

  def handle_play
    loop do
      self.display_game
      self.get_input
    end
  end

  def get_input
    loop do
      input = gets.chomp.downcase.split('')
      converted_input = convert_to_yx(input)
      return converted_input if play_validator(converted_input)
    end
  end

  def convert_to_yx(input)
    yx = [nil,nil]
    yx[0] = input[1].to_i - 1 > -1 ? input[1].to_i - 1 : nil
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
    return true if play[0] && play[1]
    p 'invalid entry'
    false
  end

end