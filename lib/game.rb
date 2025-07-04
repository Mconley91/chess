require './lib/board.rb'
require './lib/rules.rb'
require './lib/display.rb'
require './lib/input.rb'

class Game 
  attr_accessor :game_board, :player_turn, :round, :turn, :en_passant_offender
  
  def initialize
    @game_board = Board.new()
    @player_turn = 'Clear'
    @round = 1
    @turn = 0
    @selected_piece = nil
    @selected_square = nil
    @en_passant_offender = nil
  end

  include Display
  include Input
  include En_Passant
  include Checkmate

  def set_game
    @game_board.render_pieces
  end

  def handle_play
    loop do
      self.set_game
      loop do
        self.display_game
        self.set_select_piece(self.get_input)
        break if @selected_piece
      end
      loop do
        self.display_game
        self.select_square(self.get_input)
        break if @selected_piece.legal_move?(*make_arguments)
        @selected_square = nil # prevents unexpected behavior if friendly piece is selected instead of a square
      end
      self.set_en_passant_offender
      self.take_piece
      self.execute_move
      #determine winner/draw here
      self.next_turn
      self.in_check?(@player_turn, @game_board.clear_pieces, @game_board.solid_pieces)
      @selected_piece = nil
      @selected_square = nil
    end
  end

  def next_turn
    self.turn += 1
    if self.turn.even? then self.round += 1 end
    @player_turn = @player_turn == 'Clear' ? 'Solid' : 'Clear'
  end

  def set_select_piece(yx)
    if @player_turn == 'Clear'
      @selected_piece = @game_board.clear_pieces.find{|piece| piece.yx == yx && piece.in_play}
    else
      @selected_piece = @game_board.solid_pieces.find{|piece| piece.yx == yx && piece.in_play}
    end
  end

  def select_square(yx)
    if @player_turn == 'Clear'
      if friendly_collision?(yx, @game_board.clear_pieces)
        set_select_piece(yx)
      else
        @selected_square = yx
      end
    else
      if friendly_collision?(yx, @game_board.solid_pieces)
        set_select_piece(yx)
      else
        @selected_square = yx
      end
    end
  end

  def friendly_collision?(yx, color_pieces)
    return true if color_pieces.find {|piece| piece.yx == yx && piece.in_play}
    false
  end

  def execute_move
    @selected_piece.yx = @selected_square
  end

  def take_piece
    if @player_turn == 'Clear'
      @game_board.solid_pieces.find{|piece| piece.in_play = false if piece.yx == @selected_square}
      self.detect_en_passant_play 
    else
      @game_board.clear_pieces.find{|piece| piece.in_play = false if piece.yx == @selected_square}
      self.detect_en_passant_play 
    end
  end

  def make_arguments
    args = [@selected_square, @player_turn, @game_board.clear_pieces, @game_board.solid_pieces]
    args << @en_passant_offender if @selected_piece.is_a?(Pawn)
    args
  end

end