#
class Card
  attr_reader :suit, :rank, :value

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @value = find_value(rank)
  end

  private

  def find_value(rank)
    return 11 if rank.eql? 'A'
    return 10 if rank.eql? 'J'
    return 10 if rank.eql? 'Q'
    return 10 if rank.eql? 'K'
    return rank if rank.integer?
  end
end
