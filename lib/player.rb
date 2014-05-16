class Player
  
  attr_accessor :hand, :pot
  
  def initialize(pot = 500)
    @pot = pot
  end
  
  def new_hand(deck)
    @hand = Hand.deal_hand(deck)
  end
  
  def discard_all
    discard_cards(@hand.cards)
  end
  
  def show_hand
    puts hand
  end
  
  def discard?
    puts "Do you want to discard up to three cards? (y/n)"
    gets.chomp.downcase == "y" ? true : false
  end
  
  def choose_and_discard
    puts "Enter up to three cards to discard (e.g. 0,2,3)"
    begin
      choices = gets.chomp.split(',')
      raise "up to three means 1, 2 or 3" if choices.count > 3
    rescue StandardError => e
      puts e.message
      retry
    end
    
    discard_cards(choices.map { |i| @hand.cards[i] })
  end
  
  def discard_cards(cards)
    @hand.discard_cards(cards)
  end
  
  def fold?
    puts "Do you want to fold? (y/n)"
    gets.chomp.downcase == "y" ? true : false
  end
  
  def ante(amount)
    
  end
  
  def place_bet
    puts "Enter a bet or 0 to not bet."
    bet = gets.chomp.to_i
    self.pot -= bet
    bet
  end
end