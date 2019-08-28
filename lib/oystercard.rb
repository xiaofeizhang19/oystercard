class Oystercard
  attr_reader :balance, :journeys

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  MINIMUM_BALANCE = 1
  PENALTY_CHARGE = 5

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
    @current_journey = Journey.new
  end

  def top_up(amount)
    raise_if_maximum_amount_exceeded(amount)

    @balance += amount
  end

  def in_journey?
    @current_journey.in_progress?
  end

  def touch_in(entry_station)
    raise_if_low_balance

    if in_journey?
      deduct_penalty
    else
      start_journey(entry_station)
    end
  end

  def touch_out(exit_station)
    if !in_journey?
      deduct_penalty
    else
      deduct_fare
      end_journey(exit_station)
    end
  end

  private

  def start_journey(entry_station)
    @current_journey.start(entry_station)
  end

  def end_journey(exit_station)
    @current_journey.stop(exit_station)
    @journeys << @current_journey
    @current_journey = Journey.new
  end

  def deduct_fare
    deduct(MINIMUM_FARE)
  end

  def deduct_penalty
    deduct(PENALTY_CHARGE)
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
