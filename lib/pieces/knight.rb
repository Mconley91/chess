#frozen_string_literal: true

require './lib/piece.rb'

class Knight < Piece
  attr_reader :knight_icon

  def initialize(color)
    @knight_icon = color == 'white' ? "\u{2658}" : "\u{265E}"
  end

end