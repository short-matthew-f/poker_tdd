class Deck
  def self.all_cards
    [].tap do |deck|
      Card.suits.each do |suit|
        Card.values.each do |value|
          deck << Card.new(suit, value)
        end
      end
    end
  end
  
  attr_reader :cards
  
  def initialize(cards = Deck.all_cards)
    @cards = cards
  end
  
  def count
    @cards.count
  end
  
  def draw(n)
    raise "not enough cards" if n > self.count

    @cards.shift(n)
  end
  
  def replace(hand)
    @cards += hand
  end
  
  def shuffle
    @cards.shuffle!
  end

end