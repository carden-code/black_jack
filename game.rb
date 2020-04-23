#
class Game
  @cards = %w[A+ A<3 A^ A<> K+ K<3 K^ K<> D+ D<3 D^ D<> J+ J<3 J^ J<>
              10+ 10<3 10^ 10<> 9+ 9<3 9^ 9<> 8+ 8<3 8^ 8<> 7+ 7<3 7^ 7<>
              6+ 6<3 6^ 6<> 5+ 5<3 5^ 5<> 4+ 4<3 4^ 4<> 3+ 3<3 3^ 3<>
              2+ 2<3 2^ 2<>]
  attr_reader :name, :users

  def initialize
    @name = 'Black_Jack'
    @users = []
  end

  # Метод add_user добавляет пользователя.
  def add_user(user)
    @users << user
  end

  def deal_cards
    

  end


end
