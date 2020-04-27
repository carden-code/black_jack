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
    new_round
  end

  def new_round
    @cards = Deck.new
    @user.cards.clear
    @dealer.cards.clear
    @bank += user.make_a_bet(BET)
    @bank += dealer.make_a_bet(BET)
    @user.cards << @cards.deal_cards(2)
    @dealer.cards << @cards.deal_cards(2)
    @user.cards_sum
    @dealer.cards_sum
  end

  # Метод add_card_user добавляет дополнительную карту пользователю.
  def add_card_user
    return if @user.cards.flatten.size.eql? 3

    @user.cards << @cards.deal_cards(1)

    @user.cards_sum
    # open_cards if @user.sum_cards >= 21
  end

  def add_card_dealer
    return if @dealer.cards.flatten.size.eql? 3

    @dealer.cards << @cards.deal_cards(1) if @dealer.sum_cards < 17 &&
                                             @user.sum_cards <= 21
    @dealer.cards_sum
    # open_cards if @dealer.cards.flatten.size == 3 ||
    #               @dealer.sum_cards >= 17 ||
    #               @user.sum_cards > @dealer.sum_cards
  end
end

#   # Метод add_card_dealer добавляет дополнительную карту диллеру.
#   def add_card_dealer
#     return if @bank.zero?
#
#     return if @dealer[0].cards[0].size == 3
#
#     @dealer[0].cards[0] << @cards.pop if @dealer[0].sum_cards < 17 &&
#                                          # @user[0].sum_cards > @dealer[0].sum_cards &&
#                                          @user[0].sum_cards <= 21
#
#     if @dealer[0].cards[0].size == 3 && @dealer[0].cards[0].last.last == 11 && @dealer[0].sum_cards + 11 > 21
#       @dealer[0].sum_cards += 1
#     elsif @dealer[0].cards[0].size > 2
#       @dealer[0].sum_cards += @dealer[0].cards[0].last.last
#     end
#
#
#   end
# #   # Метод new_game добавляет поользователя и диллера в игру, раздаёт им карты
# #   # и считает суммы очков.
# #   def new_game
# #     return unless @bank.zero?
# #
# #     if @user.size.zero?
# #       message = ['Введите ваше имя:']
# #       name = data_input(message).first
# #       @user << User.new(name)
# #       @dealer << Dealer.new
# #     else
# #       @user[0].cards.clear && @user[0].sum_cards = 0
# #       @dealer[0].cards.clear && @dealer[0].sum_cards = 0
# #     end
# #
# #     if @user[0].money.positive? && @dealer[0].money.positive?
# #       deal_cards
# #       make_a_bet
# #     elsif @user[0].money.zero?
# #       mesage_no_money
# #     elsif @dealer[0].money.zero?
# #       message_win
# #     end
# #     @cards = Deck.new.cards.sort_by { rand }
# #   end
# #
# #   # Метод open_cards производит подсчёт очков и выявляет победителя.
# #   def open_cards
# #     add_card_dealer if @dealer[0].cards.size < 3 && @dealer[0].sum_cards < 17
# #
# #     if @user[0].sum_cards > @dealer[0].sum_cards && @user[0].sum_cards <= 21
# #       @user[0].money += @bank
# #       @bank = 0
# #       message_user_win
# #       message_new_round
# #     elsif @user[0].sum_cards > 21
# #       @dealer[0].money += @bank
# #       @bank = 0
# #       message_dealer_win
# #       message_new_round
# #     elsif @dealer[0].sum_cards > 21
# #       @user[0].money += @bank
# #       @bank = 0
# #       message_user_win
# #       message_new_round
# #     elsif @user[0].sum_cards == @dealer[0].sum_cards
# #       @user[0].money += @bank / 2
# #       @dealer[0].money += @bank / 2
# #       @bank = 0
# #       message_draw
# #       message_new_round
# #     elsif @user[0].sum_cards < @dealer[0].sum_cards && @dealer[0].sum_cards <= 21
# #       @dealer[0].money += @bank
# #       @bank = 0
# #       message_dealer_win
# #       message_new_round
# #     end
# #   end
# #
# #   # Метод message_new_round выводит сообщение.
# #   def message_new_round
# #     puts "Если хотите продолжить нажмите: '1', если нет нажмите: '0'\n\n"
# #   end
# #
# #   # Метод message_dealer_win выводит сообщение.
# #   def message_dealer_win
# #     puts "Диллер победил.\n\n"
# #     puts "Сумма очков Диллера: #{@dealer[0].sum_cards}\n\n"
# #     puts "Сумма очков #{@user[0].name}: #{@user[0].sum_cards}\n\n"
# #   end
# #
# #   # Метод message_user_win выводит сообщение.
# #   def message_user_win
# #     puts "Игрок #{@user[0].name} - Победил!\n\n"
# #     puts "Сумма очков #{@user[0].name}: #{@user[0].sum_cards}\n\n"
# #     puts "Сумма очков Диллера: #{@dealer[0].sum_cards}\n\n"
# #   end
# #
# #   # Метод message_draw выводит сообщение.
# #   def message_draw
# #     puts "Ничья!\n\n"
# #     puts "Сумма очков #{@user[0].name}: #{@user[0].sum_cards}\n\n"
# #     puts "Сумма очков Диллера: #{@dealer[0].sum_cards}\n\n"
# #   end
# # end
