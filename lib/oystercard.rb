class Oystercard
  attr_reader :balance

  MAX_BALANCE = 90

  def initialize(balance = 0.00)
    @balance = balance
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE
    @balance += amount
  end



end
