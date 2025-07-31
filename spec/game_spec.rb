# frozen_string_literal: true

require './lib/game.rb'

describe Game do

  describe '#next_player' do
    subject (:game){described_class.new}
    context 'when #next_player is called' do
      it 'changes the value of #player_turn from Clear to Solid' do
        game.next_player
        expect(game.player_turn).to eq('Solid')
      end
      it 'changes the value of #player_turn from Solid to Clear' do
        game.next_player
        game.next_player
        expect(game.player_turn).to eq('Clear')
      end
    end
  end

  describe '#next_turn' do
    subject (:game){described_class.new}
    context 'when #next_turn is called' do
      it 'increments #turn by 1' do
        expect{game.next_turn}.to change{game.turn}.by(1)
      end
    end
    context 'when #next_turn is called twice' do
      before do
        game.next_turn
      end
      it 'increments #round by 1' do
        expect{game.next_turn}.to change{game.round}.by(1)
      end
    end
    context 'when #next_turn is called three times' do
      before do
        game.next_turn
        game.next_turn
      end
      it 'does not increment #round by 1' do
        expect{game.next_turn}.to change{game.round}.by(0)
      end
    end
  end

  describe '#set_selected_piece' do
    subject (:game){described_class.new}
    context 'when it is Clears turn and #set_selected_piece is called' do
      it 'Assigns #selected_piece to a pawn' do
        game.set_selected_piece([6,0])
        expect(game.selected_piece).to be_a(Pawn)
      end
      it 'Assigns #selected_piece to a king' do
        game.set_selected_piece([7,4])
        expect(game.selected_piece).to be_a(King)
      end
      it '#selected_piece remains nil' do # selecting enemy pawn
        game.set_selected_piece([1,0])
        expect(game.selected_piece).to be(nil)
      end
    end

    context 'when it is Solids turn and #set_selected_piece is called' do
      before do
        game.next_player
      end
      it 'Assigns #selected_piece to a pawn' do
        game.set_selected_piece([1,0])
        expect(game.selected_piece).to be_a(Pawn)
      end
      it 'Assigns #selected_piece to a king' do
        game.set_selected_piece([0,4])
        expect(game.selected_piece).to be_a(King)
      end
      it '#selected_piece remains nil' do # selecting enemy pawn
        game.set_selected_piece([6,0])
        expect(game.selected_piece).to be(nil)
      end
    end
  end

  describe '#set_selected_square' do # not working yet
    subject(:game){described_class.new}
    context 'when #selected_piece is a clear pawn' do
    before do
      game.set_selected_piece([7,0])
    end
      it 'sets #selected_square to a coordinate when the move is valid 1 square play' do
        game.set_selected_square([6,0])
        expect(game.selected_square).to eq([6,0])
      end
      it 'sets #selected_square to a coordinate when the move is valid 2 square play' do
        game.set_selected_square([5,0])
        expect(game.selected_square).to eq([5,0])
      end
    end
  end
  
end