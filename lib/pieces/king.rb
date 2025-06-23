#frozen_string_literal: true

require './lib/piece.rb'

class King < Piece
  attr_reader :icon

  def initialize(color, xy)
    @icon = color == 'white' ? "\u{2654}" : "\u{265A}"
    super
  end

end