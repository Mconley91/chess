#frozen_string_literal: true

require './lib/piece.rb'

class King < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2654}" : "\u{265A}"
    super
  end

  def legal_move?(target, selected_color, clears, solids) # need to limit king move range to a single square 
    if target
      all_pieces = clears + solids
      single_square_move = self.plot_path(self.yx, target).length == 2
      # vertical move
      return true if target[1] == self.yx[1] && 
      self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false && single_square_move
      # horizontal move
      return true if target[0] == self.yx[0] && 
      self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false && single_square_move
      # diagonal move
      return true if target[0] != self.yx[0] && target[1] != self.yx[1] && 
      self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false && single_square_move
    end
  end
end