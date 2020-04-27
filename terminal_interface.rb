# Интерфейс терминала.
class TerminalInterface
  # HASH содержит методы.
  HASH = { '1' => :new_round, '2' => :add_card_dealer,
           '3' => :add_card_user, '4' => :pay_to_winner }.freeze
  BORDERLINE = '-' * 50
  NEWLINE = "\n" * 2

  attr_reader :game

  def initialize(game)
    @game = game
    start_game
  end

  def start_game
    # Цикл с игрой - опрос состояния и показ возможных действий
    puts NEWLINE
    puts "Добро пожаловать в игру 'Black_Jack'"
    puts NEWLINE

    loop do
      puts "bank: #{game.bank}\n\n"
      puts NEWLINE
      menu_items

      menu_item = gets.chomp

      break unless menu_item != '0'

      # Запуск меню (Цикл). С запросом ввода нужного пользователю пункта
      # и передаёт результат в виде параметра методу selected.
      selected(menu_item)
      puts BORDERLINE
      puts "Ваши деньги: #{game.user.money}\n\n"
      puts 'Ваши карты:'
      game.user.cards.flatten.each { |elem| print "#{elem.rank}#{elem.suit}  " }
      puts NEWLINE
      puts "Сумма очков: #{game.user.sum_cards}\n\n"
      puts BORDERLINE

      if game.bank != 0
        puts "Карты Диллера: [[**][**]]\n\n"
        puts "Сумма очков: **\n\n"
      else
        puts 'Карты Диллера:'
        game.dealer.cards.flatten.each { |elem| print "#{elem.rank}#{elem.suit}  " }
        puts NEWLINE
        puts "Сумма очков: #{game.dealer.sum_cards}\n\n"
      end
      puts BORDERLINE
    end
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
    game.send HASH[menu_item]
    message_user_win if game.bank.zero?
    message_new_round if game.bank.zero?
    message_no_money if game.user.money.zero?
    message_win if game.dealer.money.zero?
  rescue TypeError
    message_re_enter
  end

  # Метод data_input принимает параметр печатает его
  # и запрашивает ввод пользователя, результат сохранят в @args.
  def data_input(message)
    @args = []
    message.each { |mess| puts mess }
    @args << gets.chomp
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
