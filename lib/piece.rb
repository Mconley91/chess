class Piece 
  attr_accessor :yx, :in_play
  
  def initialize(color, yx, in_play = true)
    @yx = yx
    @in_play = true
  end

  def plot_path(piece, target)
    path = [piece]
    until path.last == target
      return nil if path.length > 8 # prevents game break when path unobtainable 
      y_coord = target[0] == path.last[0] ? 0 : target[0] > path.last[0] ? 1 : -1
      x_coord = target[1] == path.last[1] ? 0 : target[1] > path.last[1] ? 1 : -1
      path << [path.last[0] + y_coord, path.last[1] + x_coord]
    end
    path
  end

  def piece_in_path?(path, all_pieces)
    if path
      return true if path.find{|coords| all_pieces.any?{|piece| 
      piece.yx == coords && piece.yx != path.first && piece.yx != path.last && piece.in_play}}
      return false
    elsif path == nil
      return true
    end
    false
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
    valid_paths = [up, down, left, right]
    valid_paths
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