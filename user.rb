#
class User
  attr_reader :name, :money, :cards
  def initialize(name)
    @name = name
    @money = 100
    @cards = []
  end
end
