# Класс Card создаёт карту. Содержит масти и значения карт и
# метод определяющий значение карты.
class Card
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  attr_reader :suit, :rank, :value

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @value = find_value(rank)
  end

  # Метод ace? возращает true если @rank = 'A'
  def ace?
    @rank == 'A'
  end

  private

  # Метод find_value присваивает значение.
  def find_value(rank)
    if ace?
      11
    elsif %w[J Q K].include? rank
      10
    else
      rank
    end
  end
end
