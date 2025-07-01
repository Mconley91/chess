#frozen_string_literal: true

require './lib/piece.rb'

class Rook < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2656}" : "\u{265C}"
    super
  end

  def legal_move?(target, selected_color, clears, solids)
    if target
      # ranges are ordered low to high
      y_range = self.yx[0] > target[0] ? (target[0]..self.yx[0]).to_a : (self.yx[0]..target[0]).to_a
      x_range = self.yx[1] > target[1] ? (target[1]..self.yx[1]).to_a : (self.yx[1]..target[1]).to_a

      # makes usable coordinates from ranges
      y_squares = y_range.map{|y_cord| [y_cord, self.yx[1]]}
      x_squares = x_range.map{|x_cord| [self.yx[0], x_cord]}

      # prevents 'jumping' over pieces between self & target
      pieces_on_y = y_squares.find{|coords| solids.any?{|piece| piece.yx == coords && piece != self && piece.yx != target && piece.in_play} ||
       clears.any?{|piece| piece.yx == coords && piece != self && piece.yx != target && piece.in_play}}
      pieces_on_x = x_squares.find{|coords| solids.any?{|piece| piece.yx == coords && piece != self && piece.yx != target && piece.in_play} ||
       clears.any?{|piece| piece.yx == coords && piece != self && piece.yx != target && piece.in_play}}

      return true if target[0].between?(0,7) && target[1] == self.yx[1] && self.yx[0] && !pieces_on_y # vertical move
      return true if target[0] == self.yx[0] && target[1].between?(0,7) && !pieces_on_x # horizontal move
    end
  end

end