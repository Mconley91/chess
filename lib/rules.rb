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

module Checkmate # Refactor, separate #in_check? from #in_checkmate?

  def in_check?(player, clear_pieces, solid_pieces)
    if player == 'Clear'
      clear_king = clear_pieces.find{|piece| piece.is_a?(King)}
      if clear_king.is_in_check?(player, clear_pieces, solid_pieces)
        return true
      end
    else # if 'Solid'
      solid_king = solid_pieces.find{|piece| piece.is_a?(King)}
      if solid_king.is_in_check?(player, clear_pieces, solid_pieces)
        return true
      end
    end
    false
  end

  # def checkmate? # currently disabled while check functionality is bug-squashed
  #   if @in_check == true
  #     if @player_turn == 'Clear'
  #       @game_board.clear_pieces.each{|piece| @game_board.squares.each_with_index{|row, row_i| row.each_with_index {|square, square_i|
  #       if piece.legal_move?(*legal_move_arguments(piece, [row_i, square_i])) &&
  #         self.check_escaping_play(piece, [row_i, square_i], @player_turn) &&
  #         piece == @selected_piece

  #         p "Player: #{@player_turn}"
  #         p "Piece: #{piece}"
  #         p "Piece Current Position: #{piece.yx}"
  #         p "Legal Check Escaping Move: #{[row_i, square_i]}"

  #         return false
  #       end
  #     }}}
  #     else
  #       @game_board.solid_pieces.each{|piece| @game_board.squares.each_with_index{|row, row_i| row.each_with_index {|square, square_i| 
  #       if piece.legal_move?(*legal_move_arguments(piece, [row_i, square_i])) &&
  #         self.check_escaping_play(piece, [row_i, square_i], @player_turn) &&
  #         piece == @selected_piece
          
  #         p "Player: #{@player_turn}"
  #         p "Piece: #{piece}"
  #         p "Piece Current Position: #{piece.yx}"
  #         p "Check Escaping Move: #{[row_i, square_i]}"

  #         return false
  #       end
  #       }}}
  #     end
  #   true
  #   end
  # end

end

  