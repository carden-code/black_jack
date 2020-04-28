require_relative 'user'
require_relative 'dealer'
require_relative 'game'
require_relative 'card'
require_relative 'deck'
require_relative 'terminal_interface'
#
class BlackJack
  def initialize
    user = User.new
    game = Game.new(user)
    TerminalInterface.new(game)
  end
end
