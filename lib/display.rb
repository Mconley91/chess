# frozen_string_literal: true

module Display

  def display_game
    puts "-------------------"
    @game_board.squares.each_with_index do |row, index| 
      puts "#{8 - index} |#{row[0]}|#{row[1]}|#{row[2]}|#{row[3]}|#{row[4]}|#{row[5]}|#{row[6]}|#{row[7]}|"
    end
    puts "   A B C D E F G H"
    puts "ROUND: #{self.round}, #{self.player_turn}'s move"
    puts @selected_piece ? "Selected: #{@selected_piece.icon}" : "select a piece to play"
  end

  def display_menu
    puts "*------------------------------------------------------*"
    puts "Welcome to my Chess project!"
    puts "Use the following commands:"
    puts "Play: to start a new game against yourself or a friend"
    puts "Load: to resume from a saved game"
    puts "Exit: to close the app"
    puts "*------------------------------------------------------*"
  end

  def display_player_status
    if @in_check
      puts "#{@player_turn} is in check!" 
    end
    if checkmate?
      puts "Checkmate! #{@player_turn == 'Clear' ? 'Solid' : 'Clear'} wins!" 
      return 
    end
    if stalemate?
      puts "Stalemate!" 
      return 
    end
    if insufficient_material?
      puts "Draw! Insufficient Material"
      return
    end
  end

end