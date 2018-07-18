class Oystercard
  attr_reader :balance, :in_journey, :entry_station

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 2

  def initialize(balance = 0.00)
    @balance = balance
    @in_journey = false
  end

  def in_journey?
    !!entry_station
  end

  def top_up(amount)
    raise "Error - maximum balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient balance - Please top up' if @balance < MIN_BALANCE
    @in_journey = true
    @entry_station = station
  end

  def touch_out(fare)
    # deduct(MIN_CHARGE)
    @in_journey = false
    @entry_station = nil
    @balance -= fare
  end


private

  def deduct(fare)
    @balance -= fare
  end

end
