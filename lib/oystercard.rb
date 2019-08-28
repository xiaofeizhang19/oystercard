class Oystercard
  attr_reader :balance
  attr_reader :journeys

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    raise_if_maximum_amount_exceeded(amount)

    @balance += amount
  end

  def in_journey?
    !@station.nil?
  end

  def touch_in(entry)
    raise_if_low_balance

    @station = entry
  end

  def touch_out(exit) 
    end_journey(exit)
    deduct(MINIMUM_BALANCE)   
  end

  private

  def end_journey(exit)
    @journeys << { entry_station: @station, exit_station: exit }
    @station = nil
  end

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
