class Piece 
  attr_accessor :yx, :in_play
  
  def initialize(color, yx, in_play = true)
    @yx = yx
    @in_play = true
  end

end