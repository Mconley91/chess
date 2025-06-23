#frozen_string_literal: true

require './lib/piece.rb'

class Rook < Piece
  attr_reader :icon, :xy

  def initialize(color,xy)
    @icon = color == 'white' ? "\u{2656}" : "\u{265C}"
    @xy = xy
  end

end