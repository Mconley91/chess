# frozen_string_literal: true

require './lib/game.rb'

describe Game do

  describe '#next_player' do
  subject (:game){described_class.new}
    context 'when #next_player is called' do
      it 'changes the value of @player_turn from Clear to Solid' do
        game.next_player
        expect(game.player_turn).to eq('Solid')
      end
      it 'changes the value of @player_turn from Solid to Clear' do
        game.next_player
        game.next_player
        expect(game.player_turn).to eq('Clear')
      end
    end
  end


  
end