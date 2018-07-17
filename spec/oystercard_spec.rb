require 'oystercard'

describe Oystercard do

  it 'has a default balance of £0.00' do
    expect(subject.balance).to eq 0.00
  end


end
