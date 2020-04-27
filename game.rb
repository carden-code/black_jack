# Класс Game содержит механику игры.
# Может принимать пользователя и диллера
# Может перемешивать и раздавать карты игрокам
# Может подсчитывать суму очков
# Может принимать ставку в Банк
# Может выявлять победителя в игре.
class Game
  BET = 10

  attr_reader :user, :dealer, :bank, :cards

  def initialize(user)
    @user = user
    @dealer = Dealer.new
    @cards = Deck.new
    @bank = 0
  end

  # Метод new_round создаёт новый раунд: обновляет колоду карт,
  # удаляет старые карты игроков, делает ставку в банк, раздаёт по 2 карты игрокам,
  # считает сумму очков карт.
  def new_round
    return unless @bank.zero?

    if @user.money >= BET && @dealer.money >= BET
      @cards = Deck.new
      @user.cards.clear
      @dealer.cards.clear
      @bank += user.make_a_bet(BET)
      @bank += dealer.make_a_bet(BET)
      @user.cards << @cards.deal_cards(2)
      @dealer.cards << @cards.deal_cards(2)
      @user.cards_sum
      @dealer.cards_sum
    elsif @user.money < BET
      @user
    elsif @dealer.money < BET
      @dealer
    end
  end

  # Метод add_card_user добавляет дополнительную карту пользователю.
  def add_card_user
    return if @user.cards.flatten.size == 3 || @dealer.cards.flatten.size == 3

    @user.cards << @cards.deal_cards(1)

    @user.cards_sum

    pay_to_winner if @user.sum_cards >= 21
  end

  # Метод add_card_dealer добавляет дополнительную карту диллеру.
  def add_card_dealer
    return if @dealer.cards.flatten.size == 3

    @dealer.cards << @cards.deal_cards(1) if @dealer.sum_cards < 17 &&
                                             @user.sum_cards <= 21 &&
                                             @dealer.sum_cards <= @user.sum_cards
    @dealer.cards_sum

    pay_to_winner if @dealer.cards.flatten.size == 3 ||
                     @dealer.sum_cards >= 17 ||
                     @dealer.sum_cards >= 21 ||
                     @dealer.sum_cards > @user.sum_cards
  end

  # Метод winner сравнивает очки и выявляет победителя.
  def winner
    add_card_dealer if @dealer.cards.flatten.size < 3
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
