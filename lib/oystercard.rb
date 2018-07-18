class Oystercard
  attr_reader :balance, :in_journey

  MAX_BALANCE = 90
  MIN_BALANCE = 2

  def initialize(balance = 0.00)
    @balance = balance
    @in_journey = false
  end

  def in_journey?
    false
  end

  def top_up(amount)
    raise "Error - maximum balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in
    raise 'Insufficient balance to touch in' if @balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out(fare)
    @in_journey = false
    @balance -= fare
  end

private

def deduct(fare)
  @balance -= fare
end

end
