#frozen_string_literal: true

require './lib/piece.rb'

class Bishop < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2657}" : "\u{265D}"
    super
  end

  def legal_move?(target, selected_color, clears, solids) # WIP !!
    if target 
      all_pieces = clears + solids

      # ranges are ordered low to high
      y_range = self.yx[0] > target[0] ? (target[0]..self.yx[0]).to_a : (self.yx[0]..target[0]).to_a
      x_range = self.yx[1] > target[1] ? (target[1]..self.yx[1]).to_a : (self.yx[1]..target[1]).to_a

      squares = []

      # makes usable coordinates from ranges
      y_range.each_with_index{|cord, index| squares << [y_range[index], x_range[index]]}
      p squares

      # prevents 'jumping' over pieces between self & target
      pieces_between = squares.find{|coords| all_pieces.any?{|piece| piece.yx == coords && piece != self &&
       piece.yx != target && piece.in_play}}

       return true if target[1] != self.yx[1] && target[0] != self.yx[0] && !pieces_between
    end
  end

end