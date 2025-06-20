#frozen_string_literal: true

require './lib/piece.rb'

class Pawn < Piece
  attr_reader :pawn_icon

  def initialize(color)
    @pawn_icon = color == 'white' ? "\u{2659}" : "\u{265F}"
  end

end