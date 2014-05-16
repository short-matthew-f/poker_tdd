# -*- coding: utf-8 -*-
class Card
  attr_reader :value, :suit
  
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }
  
  CARD_ORDER_ACE_HIGH = VALUE_STRINGS.keys
  CARD_ORDER_ACE_LOW = [:ace] + VALUE_STRINGS.keys[0..-2]
  
  def initialize(suit, value)
     unless Card.suits.include?(suit) and Card.values.include?(value)
       raise "illegal suit (#{suit}) or value (#{value})"
     end

     @suit, @value = suit, value
  end
  
  def self.suits
    SUIT_STRINGS.keys
  end

  def self.values
    VALUE_STRINGS.keys
  end

  def to_s
    VALUE_STRINGS[value] + SUIT_STRINGS[suit]
  end
  
end