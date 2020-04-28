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

  # Метод deal_cards(раздать карты) принимает параметр в виде колличества карт,
  # и удаляет их из колоды. Возвращает массив с удалёнными картами.
  def deal_cards(number)
    @cards.pop(number)
  end
end
