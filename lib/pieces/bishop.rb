#frozen_string_literal: true

require './lib/piece.rb'

class Bishop < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'white' ? "\u{2657}" : "\u{265D}"
    super
  end

end