# frozen_string_literal: true

require './lib/game.rb'

def start_chess_app
  loop do
    game = Game.new
    game.display_menu
    input = gets.chomp.downcase

    case input
    when 'play'
      game.handle_two_player_game
    when 'load'
      game = game.load_game
      if game
        input = 'play'
        game.handle_two_player_game
      end
    when 'exit'
      return
    else
      puts "Invalid entry. Try again."
    end

    if input == 'play' # replay only available if playing
      game.replay
    end
  end
end

start_chess_app