#frozen_string_literal: true

module En_Passant 
  def set_en_passant_offender
    if @selected_piece.class == Pawn
      if @player_turn == 'Clear' 
        @en_passant_offender = @selected_piece if @selected_piece.yx[0] - @selected_square[0] == 2
        return
      else
        @en_passant_offender = @selected_piece if @selected_square[0] - @selected_piece.yx[0] == 2
        return
      end
    end
  end

  def detect_en_passant_play
    if @en_passant_offender
      if @player_turn == 'Clear' 
        if @selected_square == [@en_passant_offender.yx[0] - 1, @en_passant_offender.yx[1]]
          execute_en_passant(@game_board.solid_pieces)
        end
      else
        if @selected_square == [@en_passant_offender.yx[0] + 1, @en_passant_offender.yx[1]]
          execute_en_passant(@game_board.clear_pieces)
        end
      end
    end
  end

  def execute_en_passant(pieces)
    pieces.find{|piece| piece.in_play = false if piece.yx == @en_passant_offender.yx}
  end

end