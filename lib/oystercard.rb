class Oystercard
  attr_reader :balance
  attr_accessor :in_journey

  MAX_BALANCE = 90

  def initialize(balance = 0.00)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end


end
