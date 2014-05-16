class Hand
  
  attr_reader :cards
  
  def initialize(cards)
    @cards = cards
  end
  
  def self.deal_hand(deck)
    Hand.new(deck.draw(5))
  end
  
  def fill_hand(deck)
    @cards += deck.draw(5 - cards.count)
  end
  
  def count
    @cards.count
  end
  
  def discard(discard_list)
    unless cards & discard_list == discard_list
      raise "can't discard what you don't have" 
    else
      @cards -= discard_list
    end
  end
  
  
end