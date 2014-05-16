require 'rspec'
require 'hand'
require 'card'

describe 'Hand' do
  let(:da) { double("da", suit: :diamonds, value: :ace) }
  let(:d9) { double("d9", suit: :diamonds, value: :nine) }
  let(:c9) { double("c9", suit: :clubs, value: :nine) }
  let(:s9) { double("s9", suit: :spades, value: :nine) }
  let(:h9) { double("h9", suit: :hearts, value: :nine) }
  let(:ht) { double("ht", suit: :hearts, value: :ten) }
  let(:hj) { double("hj", suit: :hearts, value: :jack) }
  let(:hq) { double("hq", suit: :hearts, value: :queen) }
  let(:hk) { double("hk", suit: :hearts, value: :king) }
  let(:ha) { double("ha", suit: :hearts, value: :ace) }
  
  describe "::deal_hand" do 
    it "should draw five cards from the deck" do 
      expect(Hand.deal_hand(Deck.new).count).to eq(5) 
    end
  end

  describe "#fill_hand" do 
    subject(:hand) {
      Hand.new([da, d9])
    }
    
    
    it "should fill the hand upto five cards" do
      cards_in_deck = [da, d9, c9]

      deck = double("deck")
      deck.should_receive(:draw).with(3).and_return(cards_in_deck)
      
      hand.fill_hand(deck)
      expect(hand.count).to eq(5)
    end
  end
  
  describe "#discard" do
    subject(:hand) { Hand.new([da]) }
    it "should remove the passed cards from the hand" do
      hand.discard_cards(hand.cards)
      expect(hand.cards).to eq([])
    end
    
    it "it should raise an error if the passed cards are not in the hand" do
      expect {hand.discard_cards([d9])}
        .to raise_error "can't discard what you don't have" 
    end
  end

  describe "#rank" do
    it "should detect high card" do
      hand = Hand.new([da, d9, ht, hj, hq])
      expect(hand.rank).to eq(:high_card)
    end
    
    it "should detect a pair" do
      hand = Hand.new([da, d9, c9, hj, hq])
      expect(hand.rank).to eq(:pair)
    end
    
    it "should detect two pair" do
      hand = Hand.new([da, d9, c9, ha, hq])  
      expect(hand.rank).to eq(:two_pair) 
    end
    
    it "should detect three of a kind" do
      hand = Hand.new([da, d9, c9, s9, hq])  
      expect(hand.rank).to eq(:three_of_a_kind)
    end
    
    it "should detect straight" do
      hand = Hand.new([s9, ht, hj, hq, hk])  
      expect(hand.rank).to eq(:straight) 
    end
    
    it "should detect a flush" do
      hand = Hand.new([h9, ht, hj, hq, ha])
      expect(hand.rank).to eq(:flush)
    end
    
    it "should detect full house" do
      hand = Hand.new([c9, d9, s9, da, ha])
      expect(hand.rank).to eq(:full_house)
    end
    
    it "should detect a four of a kind" do
     hand = Hand.new([h9, d9, c9, s9, hq])
     expect(hand.rank).to eq(:four_of_a_kind)
   end
    
    it "should detect a straight flush" do
      hand = Hand.new([h9, ht, hj, hq, hk])
      expect(hand.rank).to eq(:straight_flush)
    end
    
    it "should detect a royal flush" do
      hand = Hand.new([ht, hj, hq, hk, ha])  
      expect(hand.rank).to eq(:royal_flush)
    end  
  end
end