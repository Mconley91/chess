# frozen_string_literal: true

require './lib/game.rb'

game = Game.new

loop do
  puts "*------------------------------------------------------*"
  puts "Welcome to my Chess project!"
  puts "Use the following commands:"
  puts "Play: to start a new game against yourself or a friend"
  puts "*------------------------------------------------------*"
  input = gets.chomp.downcase

  case input
  when 'play'
    game.handle_player_turn
  else
    puts "invalid entry"
  end

end
