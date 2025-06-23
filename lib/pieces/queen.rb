#frozen_string_literal: true

require './lib/piece.rb'

class Queen < Piece
  attr_reader :icon, :xy

  def initialize(color,xy)
    @icon = color == 'white' ? "\u{2655}" : "\u{265B}"
    @xy = xy
  end

end