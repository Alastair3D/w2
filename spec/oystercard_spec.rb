require 'oystercard'

describe Oystercard do

  it 'has a default balance of £0.00' do
    expect(subject.balance).to eq 0.00
  end

  it 'can be topped up' do
    expect(subject.top_up(25)).to eq 25
  end

  it 'raises an error if maximum balance is exceeded' do
    maximum_balance = Oystercard::MAX_BALANCE
    subject.top_up(maximum_balance)
    expect { subject.top_up(1) }.to raise_error "ERROR - EXCEEDS MAX. BALANCE"
  end

# Q. why does this test not pass?  fail vs. raise_error 
  # it 'raises an error if max balance is exceeded' do
  #   subject.top_up(50)
  #   expect { subject.top_up(41) }.to raise_error 'Exceeds max balance'
  # end

end
