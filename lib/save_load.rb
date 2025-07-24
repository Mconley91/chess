# frozen_string_literal: true

module Saveload

  def save_game
    Dir.mkdir('./lib/saves') if !Dir.exist?('./lib/saves')
    puts "        Name your save: "
    save_name = gets.chomp
    File.write("./lib/saves/#{save_name}.yaml", self.to_yaml)
    p '        Game saved!'
  end

  def load_game
    saves = Dir.entries("./lib/saves")
    puts "        SAVES: "
    puts saves.map{|save| save.split('.')[0]}.select{|save| save}
    puts "        Enter filename to load: "
    filename = gets.chomp.split('.')[0]
    begin
      data = YAML.load_file("./lib/saves/#{filename}.yaml", aliases: true, permitted_classes: [Game, Board, Piece, Pawn, Rook, Knight, Bishop, Queen, King]) 
    rescue
      puts '        Save not found.'
    end
    data
  end

end
