#frozen_string_literal: true

require './lib/piece.rb'

class Pawn < Piece
  attr_reader :icon, :xy

  def initialize(color, xy)
    @icon = color == 'white' ? "\u{2659}" : "\u{265F}"
    @xy = xy
  end

end