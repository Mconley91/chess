#frozen_string_literal: true

require './lib/piece.rb'

class Queen < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2655}" : "\u{265B}"
    super
  end

end