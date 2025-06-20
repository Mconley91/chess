#frozen_string_literal: true

require './lib/piece.rb'

class Queen < Piece
  attr_reader :queen_icon

  def initialize(color)
    @queen_icon = color == 'white' ? "\u{2655}" : "\u{265B}"
  end

end