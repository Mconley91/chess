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
          execute_en_passant(@game_board.solid_pieces) if @selected_piece.is_a?(Pawn)
        end
      else
        if @selected_square == [@en_passant_offender.yx[0] + 1, @en_passant_offender.yx[1]]
          execute_en_passant(@game_board.clear_pieces) if @selected_piece.is_a?(Pawn)
        end
      end
    end
  end

  def execute_en_passant(pieces)
    pieces.find{|piece| piece.in_play = false if piece.yx == @en_passant_offender.yx}
  end

end

module Checkmate
  def in_check?(player, clear_pieces, solid_pieces)
    if player == 'Clear'
      clear_pieces.find{|piece| piece.is_a?(King)}.is_in_check?
    else # if 'Solid'
      solid_pieces.find{|piece| piece.is_a?(King)}.is_in_check?
    end
  end

end

  