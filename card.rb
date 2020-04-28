#
class Card
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  attr_reader :suit, :rank, :value

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @value = find_value(rank)
  end

  private

  def find_value(rank)
    if rank == 'A'
      11
    elsif %w[J Q K].include? rank
      10
    else
      rank
    end
  end
end
