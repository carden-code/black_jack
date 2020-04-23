#
class Dealer
  attr_reader :money, :name, :cards
  def initialize
    @name = 'Dealer'
    @money = 100
    @cards = []
  end
end
