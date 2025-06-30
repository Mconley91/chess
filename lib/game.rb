require './lib/board.rb'
require './lib/rules.rb'
require './lib/display.rb'
require './lib/input.rb'

class Game 
  attr_accessor :game_board, :player_turn, :round, :turn, :piece_triggered_en_passant
  
  def initialize
    @game_board = Board.new()
    @player_turn = 'Clear'
    @round = 1
    @turn = 0
    @selected_piece = nil
    @selected_square = nil
    @piece_triggered_en_passant = nil
  end

  include Display
  include Input

  def set_game
    @game_board.render_pieces
  end

  def handle_play
    loop do
      self.set_game
      p "#{"#{@piece_triggered_en_passant.icon} Triggered En Passant" if @piece_triggered_en_passant}"
      loop do
        self.display_game
        self.set_select_piece(self.get_input)
        break if @selected_piece
      end
      loop do
        self.display_game
        self.select_square(self.get_input)
        break if @selected_piece.legal_move?(@selected_square, @player_turn, 
        @game_board.clear_pieces, @game_board.solid_pieces, @piece_triggered_en_passant)
        @selected_square = nil
      end
      self.check_for_en_passant
      self.execute_move
      self.take_piece
      #determine winner/draw here
      self.next_turn
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
    @game_board.squares[@selected_piece.yx[0]][@selected_piece.yx[1]] = '_'
    @selected_piece.yx = @selected_square
  end

  def take_piece
    if @player_turn == 'Clear'
      @game_board.solid_pieces.find{|piece| piece.in_play = false if piece.yx == @selected_square}
    else
      @game_board.clear_pieces.find{|piece| piece.in_play = false if piece.yx == @selected_square}
    end
  end

  def check_for_en_passant
    if @selected_piece.class == Pawn
      if @player_turn == 'Clear' 
        @piece_triggered_en_passant = @selected_piece.yx[0] - @selected_square[0] == 2 ? @selected_piece : nil
        return
      else
        @piece_triggered_en_passant = @selected_square[0] - @selected_piece.yx[0] == 2 ? @selected_piece : nil
        return
      end
    end
    @piece_triggered_en_passant = nil
  end

end