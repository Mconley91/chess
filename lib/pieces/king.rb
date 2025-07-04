#frozen_string_literal: true

require './lib/piece.rb'

class King < Piece
  attr_reader :icon, :color

  def initialize(color, yx)
    @icon = color == 'clear' ? "\u{2654}" : "\u{265A}"
    @color = color
    super
  end

  def legal_move?(target, selected_color, clears, solids) # need to limit king move range to a single square 
    if target
      all_pieces = clears + solids
      single_square_move = self.plot_path(self.yx, target).length == 2
      # vertical move
      return true if target[1] == self.yx[1] && 
      self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false && single_square_move
      # horizontal move
      return true if target[0] == self.yx[0] && 
      self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false && single_square_move
      # diagonal move
      return true if target[0] != self.yx[0] && target[1] != self.yx[1] && 
      self.piece_in_path?(self.plot_path(self.yx, target), all_pieces) == false && single_square_move
    end
  end

  def is_in_check?(player, clears, solids)
    perpendicular_paths = self.get_perpendicular_paths # can be obstructed by bishops, pawns, kings, knights, & allies
    diagonal_paths = self.get_diagonal_paths # can be obstructed by rooks, pawns, kings, knights, & allies
    knight_positions = self.get_knight_positions # unobstructable, just check if enemy knight is present
    

    if player == 'Clear' # WORKING HERE
      # Now that we can see the possible locations an enemy piece might be, we need to identify the location of any enemy in range
      # and determine if it is obstructed by a friendly or a compatible enemy piece
      enemy_present = solids.any?{|piece| perpendicular_paths.any?{|path| path.any?{|coord| piece.yx == coord }} && piece.in_play}

    else # if 'Solid'

    end

    # testing outputs -----------------------------
    puts "King Color: #{player}"
    puts "Perpendicular: "
    perpendicular_paths.each{|path| p path}
    puts "Diagonal: "
    diagonal_paths.each{|path| p path}
    puts "Knights: "
    knight_positions.each{|position| p position }
    # ----------------------------------------------

    return 'a boolean!'
  end

  def get_diagonal_paths
    upper_right = [self.yx]
    upper_left = [self.yx]
    lower_right = [self.yx]
    lower_left = [self.yx]

    8.times do
      if upper_right.last[0] - 1 >= 0 && upper_right.last[1] + 1 < 8
        upper_right << [upper_right.last[0] - 1, upper_right.last[1] + 1]
      end
    end
    8.times do 
      if upper_left.last[0] - 1 >= 0 && upper_left.last[1] - 1 >= 0
        upper_left << [upper_left.last[0] - 1, upper_left.last[1] - 1]
      end
    end
    8.times do
      if lower_right.last[0] + 1 < 8 && lower_right.last[1] + 1 < 8
        lower_right << [lower_right.last[0] + 1, lower_right.last[1] + 1]
      end
    end
    8.times do
      if lower_left.last[0] + 1 < 8 && lower_left.last[1] - 1 >= 0
        lower_left << [lower_left.last[0] + 1, lower_left.last[1] - 1] 
      end
    end
    paths = [upper_right, upper_left, lower_right, lower_left]
    paths
  end

  def get_perpendicular_paths
    up = [self.yx]
    down = [self.yx]
    left = [self.yx]
    right = [self.yx]

    8.times do
      if up.last[0] - 1 >= 0
        up << [up.last[0] - 1, up.last[1]]
      end
    end
    8.times do
      if down.last[0] + 1 < 8
        down << [down.last[0] + 1, down.last[1]]
      end
    end
    8.times do 
      if left.last[1] - 1 >= 0
        left << [left.last[0], left.last[1] - 1]
      end
    end
    8.times do
      if right.last[1] + 1 < 8
        right << [right.last[0], right.last[1] + 1] 
      end
    end
    paths = [up, down, left, right]
    paths
  end

  def get_knight_positions
    valid_positions = []
    all_positions = [ 
      [self.yx[0] + 1, self.yx[1] + 2],
      [self.yx[0] + 2, self.yx[1] + 1],
      [self.yx[0] + 2, self.yx[1] - 1],
      [self.yx[0] + 1, self.yx[1] - 2],
      [self.yx[0] - 1, self.yx[1] - 2],
      [self.yx[0] - 2, self.yx[1] - 1],
      [self.yx[0] - 2, self.yx[1] + 1],
      [self.yx[0] - 1, self.yx[1] + 2] ]
    all_positions.each{|position| valid_positions << position if position[0].between?(0,7) && position[1].between?(0,7)}
    valid_positions
  end

end