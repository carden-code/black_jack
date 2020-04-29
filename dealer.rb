# Класс Dealer наследуется от класса User.
class Dealer < User
  def initialize
    super 'Dealer'
  end

  # Метод add_card_dealer добавляет дополнительную карту диллеру.
  def take_card(deck)
    return if @cards.size == 3

    @cards << deck.deal_cards if @sum_cards < 17
    cards_sum
  end
end
