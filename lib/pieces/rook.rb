#frozen_string_literal: true

require './lib/piece.rb'

class Rook < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2656}" : "\u{265C}"
    super
  end

end