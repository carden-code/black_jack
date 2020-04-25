require_relative 'user'
require_relative 'dealer'
require_relative 'game'
BORDERLINE = '-' * 50
NEWLINE = "\n" * 2

# Создаёт экземпляр класса Railway и выводит приветственное сообщение.
game = Game.new
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
  puts "Ваши деньги: #{game.user.last.money}\n\n"
  puts "Ваши карты: #{game.user.last.cards[0]}\n\n"
  puts "Сумма очков: #{game.user.last.sum_cards}\n\n"
  puts BORDERLINE

  if game.bank != 0
    puts "Карты Диллера: [[**][**]]\n\n"
    puts "Сумма очков: **\n\n"
  else
    puts "Карты Диллера: #{game.dealer.last.cards[0]}\n\n"
    puts "Сумма очков: #{game.dealer.last.sum_cards}\n\n"
  end
  puts BORDERLINE
end
