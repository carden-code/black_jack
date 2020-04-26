#
class Deck
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  attr_reader :cards, :cards_rand

  def initialize
    @cards = []
    SUITS.map { |suit| VALUES.map { |value| @cards << Card.new(suit, value) } }
    @cards_rand = @cards.sort_by { rand }
  end
end