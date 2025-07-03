class Piece 
  attr_accessor :yx, :in_play
  
  def initialize(color, yx, in_play = true)
    @yx = yx
    @in_play = true
  end

  def plot_path(piece, target)
    path = [piece]
    until path.last == target
      p path # testing code, delete later
      return nil if path.length > 8 # prevents game break when path unobtainable 
      y_coord = target[0] == piece[0] ? 0 : target[0] > piece[0] ? 1 : -1
      x_coord = target[1] == piece[1] ? 0 : target[1] > piece[1] ? 1 : -1
      path << [path.last[0] + y_coord, path.last[1] + x_coord]
    end
    path
  end

  def piece_in_path?(path, all_pieces)
    if path
      return true if path.find{|coords| all_pieces.any?{|piece| piece.yx == coords && piece.yx != path.first && piece.yx != path.last && piece.in_play}}
      return false
    elsif path == nil
      return true
    end
    false
  end

end