# Класс Deck(Колода карт):
# Наполняет колоду картами.
# Перемешивает колоду.
# Раздаёт карты.
class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    @cards.shuffle!
  end

  # Метод deal_cards(раздать карты) удаляет карту из колоды.
  # Возвращает удалённую карту.
  def deal_cards
    @cards.delete(@cards.last)
  end
end
