# Класс Deck(Колода карт):
# Наполняет колоду картами.
# Перемешивает колоду.
# Раздаёт карты.
class Deck
  attr_reader :cards

  # Создаются карты и добавляются в @cards образуя колоду из 52 карт.
  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    # Перемешивает карты.
    @cards.shuffle!
  end

  # Метод deal_cards(раздать карты) удаляет карту из колоды.
  # Возвращает удалённую карту.
  def deal_cards
    @cards.delete(@cards.last)
  end
end
