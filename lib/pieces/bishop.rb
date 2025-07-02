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
      return true if target[0] != self.yx[0] && target[1] != self.yx[1] && 
       self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false
    end
  end

end