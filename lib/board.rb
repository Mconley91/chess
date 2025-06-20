# frozen_string_literal: true

require './lib/pieces/bishop.rb'
require './lib/pieces/king.rb'
require './lib/pieces/knight.rb'
require './lib/pieces/pawn.rb'
require './lib/pieces/queen.rb'
require './lib/pieces/rook.rb'

class Board
  attr_accessor :squares
  
  def initialize
    @squares = Array.new(8){Array.new(8){'_'}}
    @white_pieces = make_pieces('white')
    @black_pieces = make_pieces('black')
  end

  def make_pieces(color)
    arr = []
    8.times{|index| arr << Pawn.new(color)}
    2.times{|index| arr << Rook.new(color)}
    2.times{|index| arr << Knight.new(color)}
    2.times{|index| arr << Bishop.new(color)}
    arr << Queen.new(color)
    arr << King.new(color)
    arr
  end

  def set_board
    @squares[1].each_with_index {|square,index| @squares[1][index] = @black_pieces[index].pawn_icon}
    @squares[0][0] = @black_pieces[8].rook_icon
    @squares[0][7] = @black_pieces[9].rook_icon
    @squares[0][1] = @black_pieces[10].knight_icon
    @squares[0][6] = @black_pieces[11].knight_icon
    @squares[0][2] = @black_pieces[12].bishop_icon
    @squares[0][5] = @black_pieces[13].bishop_icon
    @squares[0][3] = @black_pieces[14].queen_icon
    @squares[0][4] = @black_pieces[15].king_icon

    @squares[6].each_with_index {|square,index| @squares[6][index] = @white_pieces[index].pawn_icon}
    @squares[7][0] = @white_pieces[8].rook_icon
    @squares[7][7] = @white_pieces[9].rook_icon
    @squares[7][1] = @white_pieces[10].knight_icon
    @squares[7][6] = @white_pieces[11].knight_icon
    @squares[7][2] = @white_pieces[12].bishop_icon
    @squares[7][5] = @white_pieces[13].bishop_icon
    @squares[7][3] = @white_pieces[14].queen_icon
    @squares[7][4] = @white_pieces[15].king_icon
  end

  def algebraic_notation
    @squares.each_with_index{|row,index| row.push(8 - index)}
    @squares.push(%w'A B C D E F G H')
  end
end