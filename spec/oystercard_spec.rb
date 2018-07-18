require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }

  it 'initializes with a default balance of £0.00' do
    expect(subject.balance).to eq 0.00
  end

  it 'initializes as not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can be topped up' do
    expect(subject.top_up(25)).to eq 25
  end

  it 'raises an error if maximum balance is exceeded' do
    maximum_balance = Oystercard::MAX_BALANCE
    subject.top_up(maximum_balance)
    expect { subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
  end

# Q. why does this test not pass?  fail vs. raise_error.. () Vs. {} + PRY
  # it 'raises an error if max balance is exceeded' do
  #   subject.top_up(50)
  #   expect { subject.top_up(41) }.to raise_error 'Exceeds max balance'
  # end

  it 'deducts the fare from the balance' do
    subject.top_up(20)
    expect(subject.deduct(3)).to eq 17
    expect { subject.deduct 3 }.to change { subject.balance }.by -3
  end

  describe '#touch_in' do
    it { is_expected.to respond_to (:touch_in) }
    it 'sets in_journey status to true' do
      subject.touch_in
        expect(subject.in_journey).to be true
        # expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to (:touch_out) }
    it 'sets in_journey status to false' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to be false
    end
  end



end
