# frozen_string_literal: true

require './lib/pieces/bishop.rb'
require './lib/pieces/king.rb'
require './lib/pieces/knight.rb'
require './lib/pieces/pawn.rb'
require './lib/pieces/queen.rb'
require './lib/pieces/rook.rb'

class Board
  attr_accessor :squares
  
  def initialize
    @squares = Array.new(8){Array.new(8){'_'}}
  end

end
