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
  puts "user: #{game.user}\n\n"
  puts "dealer: #{game.dealer}\n\n"
  puts "bank: #{game.bank.sum}\n\n"
  puts "bet: #{game.bet}\n\n"
  puts NEWLINE
  game.menu_items

  menu_item = gets.chomp

  break unless menu_item != '0'

  game.selected(menu_item)
  puts "Ваши карты: #{game.user.first.cards[0]}\n\n"
  puts "Сумма очков: #{game.user.first.cards_sum}\n\n"
  puts "Карты Диллера: [[**][**]]"
  puts "Сумма очков: **"
end
