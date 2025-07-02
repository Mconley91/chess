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
      squares = [self.yx]

      until squares.last == target
        y_coord = target[0] > self.yx[0] ? 1 : -1
        x_coord = target[1] > self.yx[1] ? 1 : -1
        squares << [squares.last[0] + y_coord, squares.last[1] + x_coord]
      end

      # prevents 'jumping' over pieces between self & target
      pieces_between = squares.find{|coords| all_pieces.any?{|piece| piece.yx == coords && piece != self && piece.yx != target && piece.in_play}}

      return true if target[1] != self.yx[1] && target[0] != self.yx[0] && !pieces_between
    end
  end

end