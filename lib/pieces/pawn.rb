#frozen_string_literal: true

require './lib/piece.rb'

class Pawn < Piece
  attr_reader :icon

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2659}" : "\u{265F}"
    super
  end

  def legal_move?(target, selected_color, clears, solids, en_passant_offender)
    if selected_color == 'Clear'
      enemy_present = solids.find{|piece| piece.yx == target && piece.in_play}
      return true if target == [self.yx[0] - 1, self.yx[1]] && !enemy_present
      return true if self.yx[0] == 6 && target == [self.yx[0] - 2, self.yx[1]] && !enemy_present
      return true if target == [self.yx[0] - 1, self.yx[1] - 1] && enemy_present || target == [self.yx[0] - 1, self.yx[1] + 1] &&
       enemy_present
      if en_passant_offender
        # p en_passant_offender.icon
        # p "#{target} - #{[en_passant_offender.yx[0] - 1, en_passant_offender.yx[1]]}"
        return true if target == [en_passant_offender.yx[0] - 1, en_passant_offender.yx[1]] && !enemy_present
      end
    else
      enemy_present = clears.find{|piece| piece.yx == target && piece.in_play}
      return true if target == [self.yx[0] + 1, self.yx[1]] && !enemy_present
      return true if self.yx[0] == 1 && target == [self.yx[0] + 2, self.yx[1]] && !enemy_present
      return true if target == [self.yx[0] + 1, self.yx[1] + 1] && enemy_present || target == [self.yx[0] + 1, self.yx[1] - 1] && 
      enemy_present
      if en_passant_offender
        return true if target == [en_passant_offender.yx[0] + 1, en_passant_offender.yx[1]] && !enemy_present
      end
    end
    false
  end

end