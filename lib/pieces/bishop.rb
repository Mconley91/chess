#frozen_string_literal: true

require './lib/piece.rb'

class Bishop < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2657}" : "\u{265D}"
    super
  end

  def legal_move?(target, selected_color, clears, solids)
    if target
      all_pieces = clears + solids

      # ranges are ordered low to high
      y_range = self.yx[0] > target[0] ? (target[0]..self.yx[0]).to_a : (self.yx[0]..target[0]).to_a
      x_range = self.yx[1] > target[1] ? (target[1]..self.yx[1]).to_a : (self.yx[1]..target[1]).to_a

      squares = []

      # makes usable coordinates from ranges
      y_range.each_with_index{|y_cord, index| squares << [y_cord, x_range[index]]}
      p squares
    end

  end
end