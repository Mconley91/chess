#frozen_string_literal: true

require './lib/piece.rb'

class Knight < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'white' ? "\u{2658}" : "\u{265E}"
    super
  end

end