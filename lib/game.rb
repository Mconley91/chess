require './lib/board.rb'
require './lib/rules.rb'
require './lib/display.rb'

class Game 
  attr_accessor :game_board
  
  def initialize
    @game_board = Board.new()
  end

  include Display

  def set_game
    @game_board.set_board
  end

  def handle_play
    self.display_game
  end
end