require 'rspec'
require 'deck'
require 'card'

describe Deck do 
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }
    
    it "should have 52 cards" do
      expect(all_cards.count).to eq(52)
    end
    
    it "should have 52 unique cards" do
      cards_as_arrays = all_cards.map do |card|
        [card.value, card.suit]
      end
      
      expect(cards_as_arrays.uniq.count).to eq(52)
    end
  end
  
  let(:cards) do 
    [
      Card.new(:diamonds, :ace),
      Card.new(:spades, :deuce),
      Card.new(:clubs, :three),
      Card.new(:clubs, :deuce),
      Card.new(:diamonds, :eight),
      Card.new(:hearts, :nine),
      Card.new(:diamonds, :king)
    ]
  end
  
  describe "#initialize" do 
    it "should start with the normal 52 card deck by default" do
      deck = Deck.new
      expect(deck.count).to eq(52)
    end
    
    it "should take an optional deck of cards" do
      deck = Deck.new(cards)
      expect(deck.count).to eq(7)
    end
  end
  
  describe "#draw" do
    subject(:deck) { Deck.new(cards) }

    it "should return the top n cards from the deck" do
      dup_cards = cards.dup
      expect(deck.draw(5)).to eq(dup_cards[0..4])
    end
    
    it "should remove the drawn cards from the deck" do
      deck.draw(2)
      expect(deck.count).to eq(5)
    end
    
    it "should not draw if there are not enough cards" do
      expect { deck.draw(9) }.to raise_error("not enough cards")
    end
  end
  
  describe "#replace" do
    subject(:deck) { Deck.new(cards) }
    
    it "return cards to the bottom of the deck" do
      hand = [Card.new(:diamonds, :deuce), Card.new(:diamonds, :seven)]
      deck.replace(hand)
      
      expect(deck.cards).to eq(cards + hand)
    end
  end
      
  
end