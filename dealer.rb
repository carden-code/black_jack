#
class Dealer
  attr_accessor :money, :sum_cards
  attr_reader :name, :cards
  def initialize
    @name = 'Dealer'
    @money = 100
    @cards = []
    @sum_cards = 0
  end

  def cards_sum
    @sum_cards = @cards[0][0][1] + @cards[0][1][1]
  end
end
