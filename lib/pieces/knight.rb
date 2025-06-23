#frozen_string_literal: true

require './lib/piece.rb'

class Knight < Piece
  attr_reader :knight_icon, :xy

  def initialize(color,xy)
    @knight_icon = color == 'white' ? "\u{2658}" : "\u{265E}"
    @xy = xy
  end

end