# frozen_string_literal: true

require './lib/game.rb'

describe Game do
  describe '#next_player' do
    it 'Changes the value of @player_turn from Clear to Solid' do
      game = Game.new
      game.next_player
      expect(game.player_turn).to eq('Solid')
    end
    it 'Changes the value of @player_turn from Solid to Clear' do
      game = Game.new
      game.next_player
      game.next_player
      expect(game.player_turn).to eq('Clear')
    end
  end
end