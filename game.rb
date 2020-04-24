require 'pry'
#
class Game
  HASH = { '1' => :add_user, '2' => :add_card_dealer,
           '3' => :add_card_user, '4' => :open_cards }.freeze

  attr_reader :name, :user, :cards, :dealer, :bet, :bank

  def initialize
    @name = 'Black_Jack'
    @user = []
    @dealer = []
    @bank = 0
    @bet = 10
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

  def message_re_enter
    puts 'Повторите ввод!'
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
    if @user.size.zero?
      message = ['Введите ваше имя:']
      name = data_input(message).first
      @user << User.new(name)
      @dealer << Dealer.new
      deal_cards
      make_a_bet
    else
      user.last.cards.clear && user.last.sum_cards = 0
      dealer.last.cards.clear && dealer.last.sum_cards = 0
      deal_cards
      make_a_bet
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
    @dealer[0].cards_sum
  end

  def make_a_bet
    @user[0].money -= @bet
    @bank += @bet
    @dealer[0].money -= @bet
    @bank += @bet
  end

  def add_card_user
    return if @user[0].cards[0].size < 2
    @user[0].cards[0] << @cards.pop
    #binding.pry
    @user[0].sum_cards += @user[0].cards[0][2][1]
  end

  def add_card_dealer
    return if @dealer[0].cards[0].size < 2
    @dealer[0].cards[0] << @cards.pop if @dealer[0].cards_sum < 17
    #binding.pry
    @dealer[0].sum_cards += @dealer[0].cards[0][2][1]
  end

  def bust
    puts 'Перебор!'
  end

  def message_new_round
    puts "Если хотите продолжить нажмите '1', если нет нажмите '0'"
  end

  def open_cards
    add_card_dealer if dealer.last.cards.size < 3 && dealer.last.sum_cards < 17
    if user.last.sum_cards > dealer.last.sum_cards && user.last.sum_cards <= 21
      user.last.money += @bank
      @bank = 0
      puts "Сумма очков #{user.last.name}: #{user.last.sum_cards}\n\n"
      puts "Игрок #{user.last.name} - Победил!"
      message_new_round
    elsif dealer.last.sum_cards > 21
      user.last.money += @bank
      @bank = 0
      puts "Сумма очков #{user.last.name}: #{user.last.sum_cards}\n\n"
      puts "Игрок #{user.last.name} - Победил!"
      message_new_round
    elsif user.last.sum_cards == dealer.last.sum_cards
      user.last.money += @bank / 2
      dealer.last.money += @bank / 2
      @bank = 0
      puts "Сумма очков #{user.last.name}: #{user.last.sum_cards}\n\n"
      puts "Сумма очков Диллера: #{dealer.last.sum_cards}\n\n"
      puts "Ничья!"
      message_new_round
    elsif user.last.sum_cards < dealer.last.sum_cards && dealer.last.sum_cards <= 21
      dealer.last.money += @bank
      @bank = 0
      puts "Диллер победил. #{dealer.last.sum_cards}"
      message_new_round
    elsif user.last.sum_cards > 21
      dealer.last.money += @bank
      @bank = 0
      puts "Диллер победил. #{dealer.last.sum_cards}"
      message_new_round
    end
  end



end
