# frozen_string_literal: true

require './lib/pieces/bishop.rb'
require './lib/pieces/king.rb'
require './lib/pieces/knight.rb'
require './lib/pieces/pawn.rb'
require './lib/pieces/queen.rb'
require './lib/pieces/rook.rb'

class Board
  attr_accessor :squares, :clear_pieces, :solid_pieces
  
  def initialize
    @squares = Array.new(8){Array.new(8){'_'}}
    @clear_pieces = make_pieces('clear')
    @solid_pieces = make_pieces('solid')
  end

  def make_pieces(color)
    if color == 'clear'
      arr = []
      # @squares[6].each_with_index{|square,index| arr << Pawn.new(color,[6,index])}
      arr << Rook.new(color,[7,0])
      arr << Rook.new(color,[7,7])
      arr << Knight.new(color,[7,1])
      arr << Knight.new(color,[7,6])
      arr << Bishop.new(color,[7,2])
      arr << Bishop.new(color,[7,5])
      arr << Queen.new(color,[7,3])
      arr << King.new(color,[7,4])
      arr
    else # solid pieces
      arr = []
      # @squares[1].each_with_index{|square,index| arr << Pawn.new(color,[1,index])}
      # arr << Rook.new(color,[0,0])
      # arr << Rook.new(color,[0,7])
      # arr << Knight.new(color,[0,1])
      # arr << Knight.new(color,[0,6])
      # arr << Bishop.new(color,[0,2])
      # arr << Bishop.new(color,[0,5])
      # arr << Queen.new(color,[0,3])
      arr << King.new(color,[0,4])
      arr
    end   
  end

  def render_pieces
    @squares.each_with_index{|row,row_i| row.each_with_index{|square,square_i| @squares[row_i][square_i] = '_'}}
    @clear_pieces.each {|piece| @squares[piece.yx[0]][piece.yx[1]] = piece.icon if piece.in_play}
    @solid_pieces.each {|piece| @squares[piece.yx[0]][piece.yx[1]] = piece.icon if piece.in_play}
  end

end