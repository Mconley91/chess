require './lib/board.rb'
require './lib/rules.rb'
require './lib/display.rb'
require './lib/input.rb'

class Game 
  attr_accessor :game_board, :player_turn, :round, :turn
  
  def initialize
    @game_board = Board.new()
    @player_turn = 'Clear'
    @round = 1
    @turn = 0
    @selected_piece = nil
    @selected_square = nil
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
        break if @selected_square
      end
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
    # will need movement rules applied per piece
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

end