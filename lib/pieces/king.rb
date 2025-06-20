#frozen_string_literal: true

require './lib/piece.rb'

class King < Piece
  attr_reader :king_icon

  def initialize(color)
    @king_icon = color == 'white' ? "\u{2654}" : "\u{265A}"
  end

end