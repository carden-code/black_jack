# Класс User содержит информацию о пользователе:
# Содержит имя
# Колличество денег
# Карты и сумму очков
class User
  attr_accessor :money, :sum_cards, :name
  attr_reader :cards

  def initialize(name = 'User')
    @name = name
    @money = 100
    @cards = []
    @sum_cards = 0
  end

  # Метод cards_sum считает сумму карт.
  def cards_sum
    @sum_cards = @cards.flatten.sum(&:value)
    arr = []
    @cards.flatten.each { |card| arr << card.rank if card.rank == 'A' }
    @sum_cards -= 10 if arr.include?('A') && @sum_cards > 21
  end

  # Метод make_a_bet делает ставку в банк,
  # вычитывая значение BET из @money.
  def make_a_bet(bet)
    return if @money < bet
    @money -= bet
    bet
  end
end
