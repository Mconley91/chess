#frozen_string_literal: true

require './lib/piece.rb'

class Queen < Piece
  attr_reader :queen_icon, :xy

  def initialize(color,xy)
    @queen_icon = color == 'white' ? "\u{2655}" : "\u{265B}"
    @xy = xy
  end

end