#
class Game
  HASH = { '1' => :new_game, '2' => :add_card_dealer,
           '3' => :add_card_user, '4' => :open_cards }.freeze

  attr_reader :user, :dealer, :bet, :bank

  def initialize
    @user = []
    @dealer = []
    @bank = 0
    @bet = 10
  end

  # Метод menu_items выводит пользовательское меню.
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

  # Метод message_re_enter выводит сообщение.
  def message_re_enter
    puts "Повторите ввод.\n\n"
  end

  # Метод selected принимает параметр из пользовательского ввода
  # и исполняет соответствующий метод.
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

  def mesage_no_money
    puts "Ваши деньги закончились. Вы проиграли!\n\n"
  end

  def message_win
    puts "Поздравляем! Вы выиграли! У Диллера нет денег.\n\n"
  end

  # Метод new_game добавляет пользователя.
  def new_game
    return unless @bank.zero?
    if @user.size.zero?
      message = ['Введите ваше имя:']
      name = data_input(message).first
      @user << User.new(name)
      @dealer << Dealer.new
    else
      @user[0].cards.clear && @user[0].sum_cards = 0
      @dealer[0].cards.clear && @dealer[0].sum_cards = 0
    end
    if @user[0].money.positive? && @dealer[0].money.positive?
      deal_cards
      make_a_bet
    elsif @user[0].money.zero?
      mesage_no_money
    elsif @dealer[0].money.zero?
      message_win
    end
  end

  def deal_cards
    @cards = { 'A♣' => 11, 'A♥' => 11, 'A♠' => 11, 'A♦' => 11, 'K♣' => 10,
               'K♥' => 10, 'K♠' => 10, 'K♦' => 10, 'D♣' => 10, 'D♥' => 10,
               'D♠' => 10, 'D♦' => 10, 'J♣' => 10, 'J♥' => 10, 'J♠' => 10,
               'J♦' => 10, '10♣' => 10, '10♥' => 10, '10♠' => 10, '10♦' => 10,
               '9♣' => 9, '9♥' => 9, '9♠' => 9, '9♦' => 9, '8♣' => 8, '8♥' => 8,
               '8♠' => 8, '8♦' => 8, '7♣' => 7, '7♥' => 7, '7♠' => 7, '7♦' => 7,
               '6♣' => 6, '6♥' => 6, '6♠' => 6, '6♦' => 6, '5♣' => 5, '5♥' => 5,
               '5♠' => 5, '5♦' => 5, '4♣' => 4, '4♥' => 4, '4♠' => 4, '4♦' => 4,
               '3♣' => 3, '3♥' => 3, '3♠' => 3, '3♦' => 3, '2♣' => 2, '2♥' => 2,
               '2♠' => 2, '2♦' => 2 }.sort.sort_by! { rand }
    @user[0].cards << @cards.pop(2)
    @dealer[0].cards << @cards.pop(2)
    @user[0].cards_sum
    @user[0].sum_cards = 12 if @user[0].cards_sum == 22
    @dealer[0].cards_sum
    @dealer[0].sum_cards = 12 if @dealer[0].cards_sum == 22
  end

  def make_a_bet
    @user[0].money -= @bet
    @bank += @bet
    @dealer[0].money -= @bet
    @bank += @bet
  end

  def add_card_user
    return if @bank.zero?
    return if @user[0].cards[0].size == 3

    @user[0].cards[0] << @cards.pop if @user[0].cards[0].size < 3
    if @user[0].cards[0].last.last == 11 && @user[0].sum_cards + 11 > 21
      @user[0].sum_cards += 1
    elsif @user[0].cards[0].size > 2
      @user[0].sum_cards += @user[0].cards[0].last.last
    end
    open_cards if @user[0].sum_cards > 21
  end

  def add_card_dealer
    return if @bank.zero?
    return if @dealer[0].cards[0].size == 3
    @dealer[0].cards[0] << @cards.pop if @dealer[0].sum_cards < 17 &&
                                         @user[0].sum_cards > @dealer[0].sum_cards &&
                                         @user[0].sum_cards <= 21
    if @dealer[0].cards[0].last.last == 11 && @dealer[0].sum_cards + 11 > 21
      @dealer[0].sum_cards += 1
    elsif @dealer[0].cards[0].size > 2
      @dealer[0].sum_cards += @dealer[0].cards[0].last.last
    end
    open_cards if @dealer[0].cards[0].size == 3 || @dealer[0].sum_cards >= 17
  end

  def open_cards
    add_card_dealer if @dealer[0].cards.size < 3 && @dealer[0].sum_cards < 17
    if @user[0].sum_cards > @dealer[0].sum_cards && @user[0].sum_cards <= 21
      @user[0].money += @bank
      @bank = 0
      message_user_win
      message_new_round
    elsif @user[0].sum_cards > 21
      @dealer[0].money += @bank
      @bank = 0
      message_dealer_win
      message_new_round
    elsif @dealer[0].sum_cards > 21
      @user[0].money += @bank
      @bank = 0
      message_user_win
      message_new_round
    elsif @user[0].sum_cards == @dealer[0].sum_cards
      @user[0].money += @bank / 2
      @dealer[0].money += @bank / 2
      @bank = 0
      message_draw
      message_new_round
    elsif @user[0].sum_cards < @dealer[0].sum_cards && @dealer[0].sum_cards <= 21
      @dealer[0].money += @bank
      @bank = 0
      message_dealer_win
      message_new_round
    end
  end

  def message_new_round
    puts "Если хотите продолжить нажмите: '1', если нет нажмите: '0'\n\n"
  end

  def message_dealer_win
    puts "Диллер победил.\n\n"
    puts "Сумма очков Диллера: #{@dealer[0].sum_cards}\n\n"
    puts "Сумма очков #{@user[0].name}: #{@user[0].sum_cards}\n\n"
  end

  def message_user_win
    puts "Игрок #{@user[0].name} - Победил!\n\n"
    puts "Сумма очков #{@user[0].name}: #{@user[0].sum_cards}\n\n"
    puts "Сумма очков Диллера: #{@dealer[0].sum_cards}\n\n"
  end

  def message_draw
    puts "Ничья!\n\n"
    puts "Сумма очков #{@user[0].name}: #{@user[0].sum_cards}\n\n"
    puts "Сумма очков Диллера: #{@dealer[0].sum_cards}\n\n"
  end
end
