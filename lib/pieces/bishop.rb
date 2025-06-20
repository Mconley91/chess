#frozen_string_literal: true

require './lib/piece.rb'

class Bishop < Piece
  attr_reader :bishop_icon

  def initialize(color)
    @bishop_icon = color == 'white' ? "\u{2657}" : "\u{265D}"
  end

end