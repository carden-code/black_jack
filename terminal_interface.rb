class TerminalInterface
  BORDERLINE = '-' * 50
  NEWLINE = "\n" * 2

  def initialize(game)
    @game = game
  end

  def start_game
    # Цикл с игрой - опрос состояния и показ возможных действий
    puts NEWLINE
    puts "Добро пожаловать в игру 'Black_Jack'"
    puts NEWLINE
    # Запуск меню (Цикл). С запросом ввода нужного пользователю пункта
    # и передаёт результат в виде параметра методу selected.
    loop do
      puts "bank: #{game.bank}\n\n"
      puts "bet: #{game.bet}\n\n"
      puts NEWLINE
      game.menu_items

      menu_item = gets.chomp

      break unless menu_item != '0'

      game.selected(menu_item)
      puts BORDERLINE
      puts "Ваши деньги: #{game.user.money}\n\n"
      puts "Ваши карты: #{game.user.cards[0].each { |elem| print "#{elem.rank} #{elem.suit}" }}\n\n"
      puts "Сумма очков: #{game.user.sum_cards}\n\n"
      puts BORDERLINE


      if game.bank != 0
        puts "Карты Диллера: [[**][**]]\n\n"
        puts "Сумма очков: **\n\n"
      else
        puts "Карты Диллера: #{game.dealer.cards[0].each { |elem| print "#{elem.rank} #{elem.suit}" }}\n\n"
        puts "Сумма очков: #{game.dealer.sum_cards}\n\n"
      end
      puts BORDERLINE
    end
  end
end
# HASH содержит методы.
HASH = { '1' => :new_game, '2' => :add_card_dealer,
         '3' => :add_card_user, '4' => :open_cards }.freeze

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
