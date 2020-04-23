#
class User
  attr_reader :name, :money, :cards, :sum_cards
  def initialize(name)
    @name = name
    @money = 100
    @cards = []
    @sum_cards = 0
  end

  def cards_sum
    @sum_cards = @cards[0][0][1] + @cards[0][1][1]
  end
end
