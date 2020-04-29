# Интерфейс терминала.
class TerminalInterface
  # HASH содержит методы.
  HASH = { '1' => :add_card_dealer, '2' => :add_card_user,
           '3' => :pay_to_winner }.freeze

  BORDERLINE = '-' * 50
  NEWLINE = "\n" * 2

  attr_reader :game

  def initialize(game)
    @game = game
    start
    start_game
  end

  def start
    puts 'Введите Ваше имя:'
    name = gets.chomp
    game.user.name = name
  end

  def start_game
    game.new_round
    puts NEWLINE
    puts "#{game.user.name} Добро пожаловать в игру 'Black_Jack'"
    puts NEWLINE

    loop do
      puts "bank: #{game.bank}\n\n"
      puts NEWLINE

      puts BORDERLINE
      puts "Ваши деньги: #{game.user.money}\n\n"
      puts 'Ваши карты:'
      game.user.cards.flatten.each { |elem| print "#{elem.rank}#{elem.suit}  " }
      puts NEWLINE
      puts "Сумма очков: #{game.user.sum_cards}"
      puts BORDERLINE

      if game.bank != 0
        puts "Карты Диллера: ***\n\n"
        puts "Сумма очков: **\n\n"
      else
        puts 'Карты Диллера:'
        game.dealer.cards.flatten.each { |elem| print "#{elem.rank}#{elem.suit}  " }
        puts NEWLINE
        puts "Сумма очков: #{game.dealer.sum_cards}"
      end
      puts BORDERLINE

      if game.bank != 0
        start_menu
        start_menu = gets.chomp
        selected(start_menu)
      elsif game.user.money.zero? || game.dealer.money.zero?
        menu_3
        menu = gets.chomp
        selected_3(menu)
      elsif game.cards.cards.size < 52
        menu_2
        menu = gets.chomp
        selected_2(menu)
      end
      break unless menu != '0'
    end
  end


  # Метод selected принимает параметр из пользовательского ввода
  # и исполняет соответствующий метод.
  def selected(start_menu)
    game.send HASH[start_menu]

    game.send HASH['3'] if game.user.sum_cards > 21

    game.send HASH['3'] if game.dealer.cards.flatten.size == 3 ||
                           game.dealer.sum_cards >= 17 ||
                           game.dealer.sum_cards >= 21

    game.send HASH['1'] if start_menu == '3' &&
                           game.dealer.cards.flatten.size < 3 &&
                           game.dealer.sum_cards < 17
    messages
  rescue TypeError
    message_re_enter
  end

  def messages
    message_user_win if game.bank.zero?
    message_new_round if game.bank.zero?
    message_no_money if game.user.money.zero?
    message_win if game.dealer.money.zero?
  end

  def selected_2(menu)
    game.new_round if menu == '1'
  end

  def start_menu
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Пропустить.',
                ' 2 - Добавить карту.',
                ' 3 - Открыть карты.',
                BORDERLINE]
    messages.each { |item| puts item }
  end

  def menu_2
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Продолжить.',
                ' 0 - Выйти из игры.',
                BORDERLINE]
    messages.each { |item| puts item }
  end

  def selected_3(menu)
    BlackJack.new if menu == '1'
  end

  def menu_3
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Новая игра.',
                ' 0 - Выйти из игры.',
                BORDERLINE]
    messages.each { |item| puts item }
  end

  # Метод message_re_enter выводит сообщение.
  def message_re_enter
    puts "Повторите ввод.\n\n"
  end

  # Метод message_no_money выводит сообщение.
  def message_no_money
    puts "Ваши деньги закончились. Вы проиграли!\n\n"
  end

  # Метод message_win выводит сообщение.
  def message_win
    puts "Поздравляем! Вы выиграли! У Диллера нет денег.\n\n"
  end

  # Метод message_new_round выводит сообщение.
  def message_new_round
    puts "Если хотите продолжить нажмите: '1', если нет нажмите: '0'\n\n"
  end

  # Метод message_user_win выводит сообщение.
  def message_user_win
    if game.winner.nil?
      puts "Ничья!\n\n"
    else
      puts "#{game.winner.name} - Победил!\n\n"
      puts "Сумма очков #{game.winner.name}: #{game.winner.sum_cards}\n\n"
    end
  end
end
