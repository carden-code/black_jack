require_relative 'user'
require_relative 'dealer'
require_relative 'game'
require_relative 'card'
require_relative 'deck'
require_relative 'terminal_interface'
#
class BlackJack
  def initialize
    user = User.new('Slava')
    game = Game.new(user) # player и game также лучше спрятать внутрь Game
    TerminalInterface.new(game)
  end
end
