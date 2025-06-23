#frozen_string_literal: true

require './lib/piece.rb'

class Bishop < Piece
  attr_reader :bishop_icon, :xy

  def initialize(color,xy)
    @bishop_icon = color == 'white' ? "\u{2657}" : "\u{265D}"
    @xy = xy
  end

end