#frozen_string_literal: true

require './lib/piece.rb'

class Queen < Piece
  attr_reader :icon, :color

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2655}" : "\u{265B}"
    @color = color
    super
  end

  def legal_move?(target, selected_color, clears, solids)
    if target
      all_pieces = clears + solids
      kings = all_pieces.select{|piece| piece.is_a?(King)}
      if kings.all?{|king| king.yx != target}
        # vertical move
        return true if target[1] == self.yx[1] && 
        self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false 
        # horizontal move
        return true if target[0] == self.yx[0] && 
        self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false 
        # diagonal move
        return true if target[0] != self.yx[0] && target[1] != self.yx[1] && 
        self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false 
      end
    end
  end
  
end