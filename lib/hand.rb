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
  
  def to_s
    cards.map { |c| c.to_s }.join(' ')
  end
  
  def empty_hand
    self.discard(@cards)
  end
  
  def discard_cards(discard_list)
    unless cards & discard_list == discard_list
      raise "can't discard what you don't have" 
    else
      @cards -= discard_list
    end
    return discard_list
  end
  
  def empty?
    @cards.empty?
  end
  
  def rank
    values = cards.map { |card| card.value }
    suits = cards.map { |card| card.suit }
    
    uniq_values = values.uniq.count
    uniq_suits = suits.uniq.count
    
    ace_low_sort_values = values.sort_by { |x| Card::CARD_ORDER_ACE_LOW.index(x) }
    ace_high_sort_values = values.sort_by { |x| Card::CARD_ORDER_ACE_HIGH.index(x) }
    
    ace_low_span = Card::CARD_ORDER_ACE_LOW.index(ace_low_sort_values.last) - 
      Card::CARD_ORDER_ACE_LOW.index(ace_low_sort_values.first)
      
    ace_high_span = Card::CARD_ORDER_ACE_HIGH.index(ace_high_sort_values.last) - 
      Card::CARD_ORDER_ACE_HIGH.index(ace_high_sort_values.first)
    
    if uniq_suits == 1 && uniq_values == 5 && ace_high_sort_values.first == :ten
      return :royal_flush
    elsif uniq_suits == 1 && uniq_values == 5 && [ace_low_span, ace_high_span].include?(4)
      return :straight_flush
    elsif [ace_low_span, ace_high_span].include?(4)
      return :straight
    elsif uniq_suits == 1
      return :flush  
    end 
    
    h = Hash.new(0)
    values.each  { |v| h[v] += 1 }
    
    if uniq_values == 2 && h.values.include?(4)
      return :four_of_a_kind
    elsif uniq_values == 2
      return :full_house
    end
    
    if uniq_values == 3 && h.values.include?(3)
      return :three_of_a_kind
    elsif uniq_values == 3
      return :two_pair
    end
    
    if uniq_values == 4
      return :pair
    else
      return :high_card
    end
  end
end








