# frozen_string_literal: true

module Display
  
  def display_board
    @game_board.squares.each{|row| puts "#{row}"}
  end

  def apply_algebraic_notation
    @game_board.algebraic_notation
  end

  def display_game
    apply_algebraic_notation
    display_board
  end
end