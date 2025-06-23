#frozen_string_literal: true

require './lib/piece.rb'

class Knight < Piece
  attr_reader :icon, :xy

  def initialize(color,xy)
    @icon = color == 'white' ? "\u{2658}" : "\u{265E}"
    @xy = xy
  end

end