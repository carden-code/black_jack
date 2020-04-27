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
    if @cards.flatten.size == 3
      @sum_cards += @cards.flatten[2].value
      @sum_cards += 1 if @cards.flatten[2].value == 11 && @sum_cards + 11 == 22
    else
      @sum_cards = @cards.flatten[0].value + @cards.flatten[1].value
      @sum_cards = 12 if @cards[0][0].value + @cards[0][1].value == 22
    end
  end

  # Метод make_a_bet делает ставку в банк,
  # вычитывая значение BET из @money.
  def make_a_bet(bet)
    @money -= 10
    bet
  end
end
