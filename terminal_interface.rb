# Интерфейс терминала.
class TerminalInterface
  BORDERLINE = '-' * 50
  NEWLINE = "\n" * 2

  attr_reader :game

  def initialize(game)
    @game = game
    start
  end

  # Метод start запрашивает имя пользователя и запускает метод start_game.
  def start
    puts 'Введите Ваше имя:'
    name = gets.chomp
    game.user.name = name
    start_game
  end

  # Метод start_game запускает цикл с отображением информации об игре.
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
      print 'Ваши карты:  '
      game.user.cards.each { |elem| print "#{elem.rank}#{elem.suit}  " }
      puts NEWLINE
      puts "Сумма очков: #{game.user.sum_cards}"
      puts BORDERLINE

      if game.bank != 0
        puts "Карты Диллера: ***\n\n"
        puts "Сумма очков: **\n\n"
      else
        print 'Карты Диллера: '
        game.dealer.cards.each { |elem| print "#{elem.rank}#{elem.suit}  " }
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
      elsif game.deck.cards.size < 52
        menu_2
        menu = gets.chomp
        selected_2(menu)
      end
      break unless menu != '0'
    end
  end

  # Метод start_menu стартовое меню выводится при запуске.
  def start_menu
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Пропустить.',
                ' 2 - Добавить карту.',
                ' 3 - Открыть карты.',
                BORDERLINE]
    messages.each { |item| puts item }
  end

  # Метод selected принимает параметр из пользовательского ввода
  # и исполняет соответствующий метод.
  def selected(start_menu)
    if start_menu == '1'
      game.dealer.take_card(game.deck)
      game.pay_to_winner
    elsif start_menu == '2'
      game.user.take_card(game.deck)
      game.pay_to_winner if game.user.sum_cards > 21
      game.dealer.take_card(game.deck) if game.bank > 0
      game.pay_to_winner
    elsif start_menu == '3'
      game.pay_to_winner
    end
    messages
  end

  # Метод menu_2 выводит меню.
  def menu_2
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Продолжить.',
                ' 0 - Выйти из игры.',
                BORDERLINE]
    messages.each { |item| puts item }
  end

  # Метод selected_2 принимает параметр из пользовательского ввода
  # и исполняет соответствующий метод.
  def selected_2(menu)
    game.new_round if menu == '1'
  end

  # Метод menu_3 выводит меню.
  def menu_3
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Новая игра.',
                ' 0 - Выйти из игры.',
                BORDERLINE]
    messages.each { |item| puts item }
  end

  # Метод selected_3 принимает параметр из пользовательского ввода
  # и исполняет соответствующий метод.
  def selected_3(menu)
    BlackJack.new if menu == '1'
  end

  # Метод messages выводит сообщения если условия true.
  def messages
    message_user_win if game.bank.zero?
    message_new_round if game.bank.zero?
    message_no_money if game.user.money.zero?
    message_win if game.dealer.money.zero?
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
