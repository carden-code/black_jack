# Класс Game содержит механику игры.
# Может принимать пользователя и диллера
# Может перемешивать и раздавать карты игрокам
# Может подсчитывать суму очков
# Может принимать ставку в Банк
# Может выявлять победителя в игре.
class Game
  BET = 10

  attr_reader :user, :dealer, :bank, :deck

  def initialize(user)
    @user = user
    @dealer = Dealer.new
    @deck = Deck.new
    @bank = 0
  end

  # Метод new_round создаёт новый раунд: обновляет колоду карт,
  # удаляет старые карты игроков, делает ставку в банк, раздаёт по 2 карты игрокам,
  # считает сумму очков карт.
  def new_round
    return unless @bank.zero?
    return if @user.money < BET || @dealer.money < BET

    @deck = Deck.new
    @user.cards.clear
    @dealer.cards.clear
    @bank += user.make_a_bet(BET)
    @bank += dealer.make_a_bet(BET)
    @user.cards << @deck.deal_cards
    @user.cards << @deck.deal_cards
    @dealer.cards << @deck.deal_cards
    @dealer.cards << @deck.deal_cards
    @user.cards_sum
    @dealer.cards_sum
  end

  # Метод winner сравнивает очки и выявляет победителя.
  def winner
    if @user.sum_cards > @dealer.sum_cards && @user.sum_cards <= 21
      @user
    elsif @dealer.sum_cards > 21
      @user
    elsif @user.sum_cards > 21
      @dealer
    elsif @user.sum_cards < @dealer.sum_cards && @dealer.sum_cards <= 21
      @dealer
    elsif @user.sum_cards == @dealer.sum_cards
      nil
    end
  end

  # Метод pay_to_winner зачисляет сумму банка победителю и обнуляет банк.
  def pay_to_winner
    if winner.nil?
      @user.money += @bank / 2
      @dealer.money += @bank / 2
    else
      winner.money += @bank
    end
    @bank = 0
  end
end
