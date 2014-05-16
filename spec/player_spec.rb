require 'rspec'
require 'player'
require 'card'
require 'hand'
require 'deck'

describe "Player" do
  let(:player) { Player.new }
  let(:deck) { Deck.new }
  let(:da) { double("da", suit: :diamonds, value: :ace) }
  let(:d9) { double("d9", suit: :diamonds, value: :nine) }
  let(:c9) { double("c9", suit: :clubs, value: :nine) }
  let(:s9) { double("s9", suit: :spades, value: :nine) }
  let(:h9) { double("h9", suit: :hearts, value: :nine) }
  let(:tiny_deck) { Deck.new([da, d9, c9, s9, h9]) }
  
  describe "#initialize" do
    it "creates a Player object with a default pot" do
      expect(player.pot).to eq(500)
    end
  end
  
  describe "#new_hand" do
    it "deals the player a new hand of five cards" do
      player.new_hand(deck)
      expect(player.hand.count).to eq(5)
    end
  end
  
  describe "#discard_all" do
    it "leaves the player with an empty hand" do
      player.new_hand(deck)
      player.discard_all
      expect(player.hand.count).to eq(0)
    end
  end
  
  describe "#discard_cards" do
    it "discards the correct cards" do
      player.new_hand(tiny_deck)
      expect(player.discard_cards([da, d9])).to eq([da, d9])
    end
    
    it "should leave the correct cards" do
      player.new_hand(tiny_deck)
      player.discard_cards([da, d9])
      expect(player.hand.cards).to eq([c9, s9, h9])
    end
  end
  
end
















