#
class Game
  attr_reader :name, :user, :cards, :dealer

  def initialize
    @name = 'Black_Jack'
    @user = []
    @dealer = []
    @cards = %w[A♣ A♥ A♠ A♦ K♣ K♥ K♠ K♦ D♣ D♥ D♠ D♦ J♣ J♥ J♠ J♦ 10♣ 10♥ 10♠ 10♦
                9♣ 9♥ 9♠ 9♦ 8♣ 8♥ 8♠ 8♦ 7♣ 7♥ 7♠ 7♦ 6♣ 6♥ 6♠ 6♦ 5♣ 5♥ 5♠ 5♦
                4♣ 4♥ 4♠ 4♦ 3♣ 3♥ 3♠ 3♦ 2♣ 2♥ 2♠ 2♦].sort_by! { rand }
  end

  # Метод add_user добавляет пользователя.
  def add_user(user)
    @user << user
    @dealer << Dealer.new
  end

  def deal_cards
    @user[0].cards << @cards.pop(2)
    @dealer[0].cards << @cards.pop(2)
  end
end
