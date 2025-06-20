#frozen_string_literal: true

require './lib/piece.rb'

class Rook < Piece
  attr_reader :rook_icon

  def initialize(color)
    @rook_icon = color == 'white' ? "\u{2656}" : "\u{265C}"
  end

end