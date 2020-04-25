# Класс User содержит информацию о пользователе:
# Содержит имя
# Колличество денег
# Карты и сумму очков
class User
  attr_accessor :money, :sum_cards
  attr_reader :name, :cards

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
    @sum_cards = 0
  end

  # Метод cards_sum считает сумму очков первых двух карт.
  def cards_sum
    @sum_cards = @cards[0][0][1] + @cards[0][1][1]
  end
end
