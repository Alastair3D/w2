class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journeys

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 2

  def initialize(balance = 0.00)
    @balance = balance
    @in_journey = false
    @journeys = {}
  end

  def in_journey?
    !!entry_station
  end

  def top_up(amount)
    raise "Error - maximum balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Insufficient balance - Please top up' if @balance < MIN_BALANCE
    @in_journey = true
    @entry_station = entry_station
    @journeys[:entry_station] = @entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_CHARGE)
    @in_journey = false
    @exit_station = exit_station
    @journeys[:exit_station] = exit_station
    @entry_station = nil
    return @balance
  end


private

  def deduct(fare)
    @balance -= fare
  end

end
