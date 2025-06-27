#frozen_string_literal: true

require './lib/piece.rb'

class Knight < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2658}" : "\u{265E}"
    super
  end

  def legal_move?(target, selected_color, clears, solids)
    
  end
end