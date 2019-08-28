class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise_if_maximum_amount_exceeded(amount)

    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise_if_low_balance

    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def raise_if_low_balance
    raise 'Minimum balance 1 required' if low_balance?
  end

  def low_balance?
    @balance < 1
  end

  def raise_if_maximum_amount_exceeded(amount)
    raise 'Maximum limit of 90 exceeded' if maximum_amount_exceeded?(amount)
  end

  def maximum_amount_exceeded?(amount)
    balance + amount > MAXIMUM_BALANCE
  end
end
