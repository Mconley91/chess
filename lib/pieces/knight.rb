#frozen_string_literal: true

require './lib/piece.rb'

class Knight < Piece
  attr_reader :icon, :color

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2658}" : "\u{265E}"
    @color = color
    super
  end

  def legal_move?(target, selected_color, clears, solids)
    all_pieces = clears + solids
    kings = all_pieces.select{|piece| piece.is_a?(King)}
    if kings.all?{|king| king.yx != target}
      return true if self.get_knight_positions.include?(target)
    end
  end
end