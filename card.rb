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
    return 11 if rank == 'A'
    return 10 if rank == 'J'
    return 10 if rank == 'Q'
    return 10 if rank == 'K'
    return rank if rank.class == Integer
  end
end
