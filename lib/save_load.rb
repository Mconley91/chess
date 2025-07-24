# frozen_string_literal: true

module Saveload

  def save_game
    if Dir.exist?('./lib/saves')
      puts "Name your save: "
      save_name = gets.chomp
      File.write("./lib/saves/#{save_name}.yaml", self.to_yaml)
      p 'Game saved!'
    else
      Dir.mkdir('./lib/saves')
      puts "Name your save: "
      save_name = gets.chomp
      File.write("./lib/saves/#{save_name}.yaml", self.to_yaml)
      p 'Game saved!'
    end
  end

  def load_game
    saves = Dir.entries("./lib/saves")
    puts "SAVES: "
    saves.each{|save| puts save.split('.')[0]}
    puts "Enter file to load: "
    filename = gets.chomp.split('.')[0]
    begin
      data = YAML.load_file("./lib/saves/#{filename}.yaml", aliases: true, permitted_classes: [Game, Board, Piece, Pawn, Rook, Knight, Bishop, Queen, King]) 
    rescue
      puts 'Invalid entry'
    end
    data
  end

end
