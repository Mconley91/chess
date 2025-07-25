# frozen_string_literal: true

module Input
  def get_input
    input = gets.chomp.downcase.split('')

    if input.join == 'save'
      self.save_game
      return
    end

    if input.join == 'load'
      @load_saved_game = self.load_game
      if @load_saved_game
        @quitting = true
        return
      end
      return
    end

    if input.join == 'quit'
      @quitting = true
      return
    end

    return convert_to_yx(input) if play_validator(input)
  end

  def convert_to_yx(input)
    yx = [nil,nil]
    yx[0] = 8 - input[1].to_i
    case input[0]
      when 'a' 
        yx[1] = 0
      when 'b' 
        yx[1] = 1
      when 'c' 
        yx[1] = 2
      when 'd' 
        yx[1] = 3
      when 'e' 
        yx[1] = 4
      when 'f' 
        yx[1] = 5
      when 'g' 
        yx[1] = 6
      when 'h' 
        yx[1] = 7
    end
    yx
  end

  def play_validator(play)
    return true if  %w"a b c d e f g h".any?(play[0]) && play[1].to_i.between?(1,8) && play.length == 2
    false
  end
end

