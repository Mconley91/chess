#frozen_string_literal: true

require './lib/piece.rb'

class Pawn < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'white' ? "\u{2659}" : "\u{265F}"
    super
  end

end