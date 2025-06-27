#frozen_string_literal: true

require './lib/piece.rb'

class Bishop < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2657}" : "\u{265D}"
    super
  end

  def legal_move?(target, selected_color, clears, solids)
    
  end
end