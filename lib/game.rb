require './lib/board.rb'
require './lib/rules.rb'
require './lib/display.rb'
require './lib/input.rb'
require './lib/save_load.rb'
require 'yaml'

class Game 
  attr_accessor :game_board, :player_turn, :round, :turn, :en_passant_offender, :in_check, :quitting, :load_saved_game, :selected_piece, :selected_square
  
  def initialize
    @game_board = Board.new()
    @player_turn = 'Clear'
    @round = 1
    @turn = 0
    @selected_piece = nil
    @selected_square = nil
    @en_passant_offender = nil
    @in_check = false
    @quitting = false
    @load_saved_game = nil
  end

  include Display
  include Input
  include En_Passant
  include Checkmate
  include Pawn_Promotion
  include Draw
  include Castling
  include Saveload

  def set_game
    @game_board.render_pieces
  end

  def handle_two_player_game
    self.set_game
    self.display_game
    self.display_game_commands
    loop do
      @selected_piece = nil
      @selected_square = nil
      self.set_game
      loop do
        self.set_select_piece(self.get_input)
        return if @quitting # exits loop if quitting or loading save
        break if @selected_piece
        self.display_game
      end
      loop do
        self.display_game
        self.select_square(self.get_input)
        return if @quitting # exits loop if quitting or loading save
        break if @selected_piece.legal_move?(*legal_move_arguments(@selected_piece, @selected_square)) && 
        self.check_escaping_play(@selected_piece, @selected_square, @player_turn)
        @selected_square = nil # prevents unexpected behavior if friendly piece is selected instead of a square
      end
      if @en_passant_offender
        self.detect_en_passant_play 
      else
        self.take_piece
      end
      self.set_en_passant_offender
      self.execute_move
      self.update_moved_status
      self.promote_pawn
      self.next_player
      self.set_game
      self.display_game
      @in_check = self.in_check?(@player_turn, @game_board.clear_pieces, @game_board.solid_pieces)
      self.display_player_status
      return if checkmate? || stalemate? || insufficient_material?
      self.next_turn
    end
  end

  def next_player
    @player_turn = @player_turn == 'Clear' ? 'Solid' : 'Clear'
  end

  def next_turn
    self.turn += 1
    if self.turn.even? then self.round += 1 end
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

  def update_moved_status
    @selected_piece.has_moved = true
  end

  def take_piece
    if @player_turn == 'Clear'
      @game_board.solid_pieces.find{|piece| piece.in_play = false if piece.yx == @selected_square}
    else
      @game_board.clear_pieces.find{|piece| piece.in_play = false if piece.yx == @selected_square}
    end
  end

  def legal_move_arguments(piece, square)
    args = [square, @player_turn, @game_board.clear_pieces, @game_board.solid_pieces]
    args << @en_passant_offender if piece.is_a?(Pawn)
    args << self.can_castle? if piece.is_a?(King)
    args
  end

  def check_escaping_play(piece, square, player_turn) # also prevents moving into check
    return false if !piece.in_play
    color = player_turn.downcase
    all_pieces = @game_board.clear_pieces + @game_board.solid_pieces
    target_piece = all_pieces.find{|target_piece| target_piece.yx == square && target_piece.in_play}

    if piece.is_a?(King)
      dummy_piece = King.new(color, square)
    else
      dummy_piece = Pawn.new(color, square)
    end
    all_pieces << dummy_piece

    piece.in_play = false
    if target_piece
      target_piece.in_play = false
    end

    if dummy_piece.is_a?(King)
      in_check = dummy_piece.find_checks(color, all_pieces).length > 0 
    else
      player_king = all_pieces.find{|piece| piece.is_a?(King) && piece.color == color}
      in_check = player_king.find_checks(color, all_pieces).length > 0
    end

    dummy_piece.in_play = false
    piece.in_play = true
    if target_piece
      target_piece.in_play = true
    end

    !in_check ? true : false
  end

  def replay
    loop do
      self.display_replay_query
      answer = gets.chomp.downcase
      if answer == 'n'
        break
      elsif answer == 'y'
        game = Game.new
        game.handle_two_player_game
      end
    end
  end

end