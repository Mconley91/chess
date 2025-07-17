#frozen_string_literal: true

module En_Passant 
  def set_en_passant_offender
    if @selected_piece.class == Pawn
      if @player_turn == 'Clear' && @selected_piece.yx[0] - @selected_square[0] == 2
        @en_passant_offender = @selected_piece
        return
      elsif @player_turn == 'Solid' && @selected_square[0] - @selected_piece.yx[0] == 2
        @en_passant_offender = @selected_piece
        return
      end
    end
    @en_passant_offender = nil
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

  def checkmate?
    if @in_check == true
      if @player_turn == 'Clear'
        @game_board.clear_pieces.each{|piece| @game_board.squares.each_with_index{|row, row_i| row.each_with_index {|square, square_i|
        if piece.legal_move?(*legal_move_arguments(piece, [row_i, square_i])) &&
          self.check_escaping_play(piece, [row_i, square_i], @player_turn) &&
          piece.in_play

          # p "Piece That Can End Check: #{piece.icon} at #{piece.yx}"
          # p "Legal Check Escaping Move: #{[row_i, square_i]}"

          return false
        end
      }}}
      else # if 'Solid'
        @game_board.solid_pieces.each{|piece| @game_board.squares.each_with_index{|row, row_i| row.each_with_index {|square, square_i| 
        if piece.legal_move?(*legal_move_arguments(piece, [row_i, square_i])) &&
          self.check_escaping_play(piece, [row_i, square_i], @player_turn) &&
          piece.in_play

          # p "Piece That Can End Check: #{piece.icon} at #{piece.yx}"
          # p "Legal Check Escaping Move: #{[row_i, square_i]}"

          return false
        end
        }}}
      end
    true
    end
  end

end

module Pawn_Promotion
  def promote_pawn
    color = @player_turn.downcase
    if @selected_piece.is_a?(Pawn) && @selected_square[0] == 0
      pick_piece(color)
      @selected_piece.in_play = false
    end
  end

  def pick_piece(color)
    if color == 'clear'
      pieces = @game_board.clear_pieces
    else
      pieces = @game_board.solid_pieces
    end
    loop do
      puts "Promote Your Pawn! Enter Rook, Knight, Bishop or Queen"
      input = gets.chomp.downcase
      case input
      when 'rook'
        pieces << Rook.new(color, @selected_square)
        return
      when 'knight'
        pieces << Knight.new(color, @selected_square)
        return
      when 'bishop'
        pieces << Bishop.new(color, @selected_square)
        return
      when 'queen'
        pieces << Queen.new(color, @selected_square)
        return
      end
    end
  end

end