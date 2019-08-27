class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "Maximum limit of 90 exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end


end
