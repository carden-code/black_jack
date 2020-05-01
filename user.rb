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

  # Метод add_card_user добавляет дополнительную карту пользователю.
  def take_card(deck)
    #return if @cards.size == 3

    @cards << deck.deal_cards
    cards_sum
  end

  # Метод cards_sum считает сумму карт.
  def cards_sum
    @sum_cards = @cards.sum(&:value)
    @sum_cards -= 10 if @cards.any?(&:ace?) && @sum_cards > 21
  end

  # Метод make_a_bet делает ставку в банк,
  # вычитывая значение BET из @money.
  def make_a_bet(bet)
    return if @money < bet

    @money -= bet
    bet
  end
end
