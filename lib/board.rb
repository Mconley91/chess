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
    if color == 'white'
      arr = []
      @squares[6].each_with_index{|square,index| arr << Pawn.new(color,[6,index])}
      arr << Rook.new(color,[7,0])
      arr << Rook.new(color,[7,7])
      arr << Knight.new(color,[7,1])
      arr << Knight.new(color,[7,6])
      arr << Bishop.new(color,[7,2])
      arr << Bishop.new(color,[7,5])
      arr << Queen.new(color,[7,3])
      arr << King.new(color,[7,4])
      arr
    else # black pieces
      arr = []
      @squares[1].each_with_index{|square,index| arr << Pawn.new(color,[1,index])}
      arr << Rook.new(color,[0,0])
      arr << Rook.new(color,[0,7])
      arr << Knight.new(color,[0,1])
      arr << Knight.new(color,[0,6])
      arr << Bishop.new(color,[0,2])
      arr << Bishop.new(color,[0,5])
      arr << Queen.new(color,[0,3])
      arr << King.new(color,[0,4])
      arr
    end   
  end

  def set_board
    @white_pieces.each{|piece| p piece}



    # @squares[1].each_with_index {|square,index| @squares[1][index] = @black_pieces[index].pawn_icon}
    # @squares[0][0] = @black_pieces[8].rook_icon
    # @squares[0][7] = @black_pieces[9].rook_icon
    # @squares[0][1] = @black_pieces[10].knight_icon
    # @squares[0][6] = @black_pieces[11].knight_icon
    # @squares[0][2] = @black_pieces[12].bishop_icon
    # @squares[0][5] = @black_pieces[13].bishop_icon
    # @squares[0][3] = @black_pieces[14].queen_icon
    # @squares[0][4] = @black_pieces[15].king_icon

    # @squares[6].each_with_index {|square,index| @squares[6][index] = @white_pieces[index].pawn_icon}
    # @squares[7][0] = @white_pieces[8].rook_icon
    # @squares[7][7] = @white_pieces[9].rook_icon
    # @squares[7][1] = @white_pieces[10].knight_icon
    # @squares[7][6] = @white_pieces[11].knight_icon
    # @squares[7][2] = @white_pieces[12].bishop_icon
    # @squares[7][5] = @white_pieces[13].bishop_icon
    # @squares[7][3] = @white_pieces[14].queen_icon
    # @squares[7][4] = @white_pieces[15].king_icon
  end

end