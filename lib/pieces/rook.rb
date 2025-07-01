#frozen_string_literal: true

require './lib/piece.rb'

class Rook < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2656}" : "\u{265C}"
    super
  end

  def legal_move?(target, selected_color, clears, solids)
    #returns true for all horizontal and vertical moves
    #can not jump over other pieces
    #may land on squares occupied by enemy pieces
    if target
      return true if target[0].between?(0,7) && target[1] == self.yx[1] #vertical move
      return true if target[0] == self.yx[0] && target[1].between?(0,7) #horizontal move
    end
  end

end