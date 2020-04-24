require 'pry'
#
class Game
  HASH = { '1' => :add_user, '2' => :add_card_dealer,
           '3' => :add_card_user }.freeze

  attr_reader :name, :user, :cards, :dealer, :bet, :bank

  def initialize
    @name = 'Black_Jack'
    @user = []
    @dealer = []
    @bank = []
    @bet = 10
    @cards = { 'A♣' => 10, 'A♥' => 10, 'A♠' => 10, 'A♦' => 10, 'K♣' => 10,
               'K♥' => 10, 'K♠' => 10, 'K♦' => 10, 'D♣' => 10, 'D♥' => 10,
               'D♠' => 10, 'D♦' => 10, 'J♣' => 10, 'J♥' => 10, 'J♠' => 10,
               'J♦' => 10, '10♣' => 10, '10♥' => 10, '10♠' => 10, '10♦' => 10,
               '9♣' => 9, '9♥' => 9, '9♠' => 9, '9♦' => 9, '8♣' => 8, '8♥' => 8,
               '8♠' => 8, '8♦' => 8, '7♣' => 7, '7♥' => 7, '7♠' => 7, '7♦' => 7,
               '6♣' => 6, '6♥' => 6, '6♠' => 6, '6♦' => 6, '5♣' => 5, '5♥' => 5,
               '5♠' => 5, '5♦' => 5, '4♣' => 4, '4♥' => 4, '4♠' => 4, '4♦' => 4,
               '3♣' => 3, '3♥' => 3, '3♠' => 3, '3♦' => 3, '2♣' => 2, '2♥' => 2,
               '2♠' => 2, '2♦' => 2 }.sort.sort_by! { rand }
  end

  def menu_items
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Начать игру.',
                ' 2 - Пропустить.',
                ' 3 - Добавить карту.',
                ' 4 - Открыть карты.',
                BORDERLINE,
                '  0 - Для выхода из программы.']
    messages.each { |item| puts item }
  end

  def selected(menu_item)
    send HASH[menu_item]
  rescue TypeError
    message_re_enter
  end

  def data_input(message)
    @args = []
    message.each { |mess| puts mess }
    @args << gets.chomp
  end

  # Метод add_user добавляет пользователя.
  def add_user
    message = ['Введите ваше имя:']
    name = data_input(message).first

    @user << User.new(name)
    @dealer << Dealer.new
    deal_cards
    make_a_bet
  end

  def deal_cards
    @user[0].cards << @cards.pop(2)
    @dealer[0].cards << @cards.pop(2)
    @user[0].cards_sum
    @dealer[0].cards_sum
  end

  def make_a_bet
    @user[0].money -= @bet
    @bank << @bet
    @dealer[0].money -= @bet
    @bank << @bet
  end

  def add_card_user
    return unless @user[0].cards.size >= 2
    @user[0].cards << @cards.pop
    @user[0].sum_cards += @user[0].cards[1][1]
  end

  def add_card_dealer
    return if @dealer[0].cards[0].size < 2
    @dealer[0].cards << @cards.pop if @dealer[0].cards_sum <= 17
    @dealer[0].sum_cards += @dealer[0].cards[1][1]
  end



end
