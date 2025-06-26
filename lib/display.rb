# frozen_string_literal: true

module Display

  def display_game
    @game_board.squares.each_with_index do |row, index| 
      puts "#{8 - index} |#{row[0]}|#{row[1]}|#{row[2]}|#{row[3]}|#{row[4]}|#{row[5]}|#{row[6]}|#{row[7]}|"
    end
    puts "   A B C D E F G H"
    puts "ROUND: #{self.round}, #{self.player_turn}'s move"
    puts @selected_piece ? "Selected: #{@selected_piece.icon}" : "select a piece to play"
  end


end