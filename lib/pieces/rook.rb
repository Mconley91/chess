#frozen_string_literal: true

require './lib/piece.rb'

class Rook < Piece
  attr_reader :icon

  def initialize(color, xy)
    @icon = color == 'white' ? "\u{2656}" : "\u{265C}"
    super
  end

end