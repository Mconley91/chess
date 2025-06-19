# frozen_string_literal: true

module Display
  
  def display_board
    @game_board.squares.each{|row| puts "#{row}"}
  end

  def display_game
    display_board
  end
end