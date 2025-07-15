#frozen_string_literal: true

require './lib/piece.rb'

class King < Piece
  attr_reader :icon, :color

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2654}" : "\u{265A}"
    @color = color
    super
  end

  def legal_move?(target, selected_color, clears, solids) 
    if target
      all_pieces = clears + solids
      single_square_move = self.plot_path(self.yx, target).length == 2
      kings = all_pieces.select{|piece| piece.is_a?(King)}
      if kings.all?{|king| king.yx != target} && !self.moving_into_check?(target, selected_color, clears, solids)
        # vertical move
        return true if target[1] == self.yx[1] && 
        self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false && single_square_move
        # horizontal move
        return true if target[0] == self.yx[0] && 
        self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false && single_square_move
        # diagonal move
        return true if target[0] != self.yx[0] && target[1] != self.yx[1] && 
        self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false && single_square_move
      end
    end
  end

  def is_in_check?(player, clears, solids)
    color = player.downcase
    all_pieces = clears + solids
    return true if self.find_checks(color, all_pieces).length > 0
  end

  def find_checks(color, all_pieces)
    perpendicular_paths = self.get_perpendicular_paths 
    diagonal_paths = self.get_diagonal_paths 
    knight_positions = self.get_knight_positions
    all_checks = [
      self.perpendicular_checks(perpendicular_paths, all_pieces, color),
      self.diagonal_checks(diagonal_paths, all_pieces, color),
      self.pawn_checks(all_pieces, color),
      self.knight_checks(knight_positions, all_pieces, color)
    ].flatten
    # puts "PLAYER: #{color}, CHECK FROM: #{all_checks}" # helpful troubleshooting readout of pieces causing check
    all_checks
  end

  def moving_into_check?(target, color, clears, solids)
    all_pieces = clears + solids
    target_piece = all_pieces.find{|piece| piece.yx == target && piece.color != color && piece.in_play == true}
    if target_piece
      target_piece.in_play = false
    end
    dummy_king = King.new(color, target)
    dummy_king.in_play = false
    self.in_play = false # makes the king 'invisible' for calculating checks
    doomed_move = dummy_king.is_in_check?(color, clears, solids)
    self.in_play = true
    if target_piece
      target_piece.in_play = true
    end
    if doomed_move
      true
    end
  end

  # def king_cant_move?(player, clears, solids)
  #   if self.is_in_check?(player, clears, solids)
  #     # check if squares around king are 1.) moving into check, 2.) occupied by friendly pieces, 3.) moving out of bounds
  #     color = player.downcase
  #     possible_moves = [
  #       [self.yx[0] + 1, self.yx[1] + 1], # bottom right
  #       [self.yx[0], self.yx[1] + 1],     # right
  #       [self.yx[0] - 1, self.yx[1] + 1], # top right
  #       [self.yx[0] - 1, self.yx[1]],     # top
  #       [self.yx[0] - 1, self.yx[1] - 1], # top left
  #       [self.yx[0], self.yx[1] - 1],     # left
  #       [self.yx[0] + 1, self.yx[1] - 1], # bottom left
  #       [self.yx[0] + 1, self.yx[1]]      # bottom
  #     ]
  #     not_out_of_bounds = possible_moves.select{|move| move[0].between?(0,7) && move[1].between?(0,7)}
  #     not_occupied_by_friends = color == 'clear' ? 
  #     not_out_of_bounds.select{|move| clears.find{|piece| move == piece.yx} ? false : true} :
  #     not_out_of_bounds.select{|move| solids.find{|piece| move == piece.yx} ? false : true}
  #     not_moving_into_check = not_occupied_by_friends.select{|move| !moving_into_check?(move, color, clears, solids)}
  #     # p not_moving_into_check # troubleshooting code, remove later
  #     if not_moving_into_check.length > 0
  #       return false
  #     else
  #       return true
  #     end
  #   end
  #   false
  # end

  def perpendicular_checks(paths, pieces, color)
    checking_pieces = []
    paths.each do|path| 
      path.each do |coord| 
        piece_at_coord = pieces.find{|piece| piece.yx == coord && piece != self && piece.in_play}
        if piece_at_coord
          if enemy_rooks_and_queens(piece_at_coord, color)
            checking_pieces << piece_at_coord
            break
          else
            break
          end
        end
      end
    end
    checking_pieces
  end

  def diagonal_checks(paths, pieces, color)
    checking_pieces = []
    paths.each do|path| 
      path.each do |coord| 
        piece_at_coord = pieces.find{|piece| piece.yx == coord && piece != self && piece.in_play}
        if piece_at_coord
          if enemy_bishops_and_queens(piece_at_coord, color)
            checking_pieces << piece_at_coord
            break
          else
            break
          end
        end
      end
    end
    checking_pieces
  end

  def pawn_checks(pieces, color)
    checking_pieces = []
    if color == 'clear'
      right_piece = pieces.find{|piece| piece.yx == [self.yx[0] - 1, self.yx[1] + 1] && piece.in_play}
      left_piece = pieces.find{|piece| piece.yx == [self.yx[0] - 1, self.yx[1] - 1] && piece.in_play}
      pawn_positions = [right_piece, left_piece]
    else # if solids
      right_piece = pieces.find{|piece| piece.yx == [self.yx[0] + 1, self.yx[1] + 1] && piece.in_play}
      left_piece = pieces.find{|piece| piece.yx == [self.yx[0] + 1, self.yx[1] - 1] && piece.in_play}
      pawn_positions = [right_piece, left_piece]
    end
    pawn_positions.each do |pawn|
      if pawn
        if enemy_pawns(pawn, color)
          checking_pieces << pawn
        end
      end
    end
    checking_pieces
  end

  def knight_checks(positions, pieces, color)
    checking_pieces = []
    positions.each do |position| 
        piece_at_coord = pieces.find{|piece| piece.yx == position && piece.in_play}
        if piece_at_coord
          if enemy_knights(piece_at_coord, color)
            checking_pieces << piece_at_coord
          end
        end
    end
    checking_pieces
  end

  def enemy_rooks_and_queens(piece, color)
    piece.is_a?(Rook) && piece.color != color || piece.is_a?(Queen) && piece.color != color
  end

  def enemy_bishops_and_queens(piece, color)
    piece.is_a?(Bishop) && piece.color != color || piece.is_a?(Queen) && piece.color != color
  end

  def enemy_pawns(piece, color)
    piece.is_a?(Pawn) && piece.color != color
  end

  def enemy_knights(piece, color)
    piece.is_a?(Knight) && piece.color != color
  end

end