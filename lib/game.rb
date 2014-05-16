class Game
  
  attr_accessor :players, :deck
  
  def initialize(players = [Player.new, Player.new])
    @players = players
    @deck = Deck.new
  end
  
  def play
    folding_players = []
    discarded_cards = []
    pool = call_for_ante
    deal_out_hands
    pool += place_bets
    discarded_cards += ask_for_discard
    replenish_cards
    pool += place_bets
    reveal_winners
  end
  
  def replenish_cards
    players.each do |player|
      player.hand.fill_hand
    end
  end
  
  def reveal_winners
    
  end
  
  def call_for_ante
    @players.each { |p| p.ante(10) }
    @player.count * 10
  end
  
  def deal_out_hands
    @players.each do |player|
      player.new_hand(@deck)
    end
  end
  
  def place_bets
    pool = 0
    @players.each do |player|
      player.show_hand
      if player.fold?
        folding_players << player
        next
      end
      pool += player.place_bet
    end
    pool
  end
  
  def ask_for_discard
    @players.each do |player|
      if player.discard?
        player.choose_and_discard
      end
    end
  end
end