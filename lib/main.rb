# frozen_string_literal: true

require './lib/game.rb'

loop do
  game = Game.new
  game.display_menu
  input = gets.chomp.downcase

  case input
  when 'play'
    game.handle_two_player_game
  else
    puts "invalid entry"
  end

  if input == 'play'
    game.replay
  end

end
