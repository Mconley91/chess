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
        break if @selected_piece.legal_move?(@selected_square, @player_turn, 
        @game_board.clear_pieces, @game_board.solid_pieces, @en_passant_offender)
        @selected_square = nil
      end
      self.set_en_passant_offender
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
      self.detect_en_passant_play 
    else
      @game_board.clear_pieces.find{|piece| piece.in_play = false if piece.yx == @selected_square}
      self.detect_en_passant_play 
    end
  end

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
          @game_board.solid_pieces.find{|piece| piece.in_play = false if piece.yx == @en_passant_offender.yx}
        end
      else
        if @selected_square == [@en_passant_offender.yx[0] + 1, @en_passant_offender.yx[1]]
          @game_board.clear_pieces.find{|piece| piece.in_play = false if piece.yx == @en_passant_offender.yx}
        end
      end
    end
  end

end