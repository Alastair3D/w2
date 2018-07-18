require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }
  let(:entry_station) { double :entry_station}
# Q Translate this.  Syntax options for doubles.
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
    expect { subject.top_up(1) }.to raise_error "Error - maximum balance of #{maximum_balance} exceeded"
  end
# Q. why does this test not pass?  fail vs. raise_error.. () Vs. {} + PRY

  describe '#touch_in' do
    # it { is_expected.to respond_to (:touch_in) }
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it 'will not touch inif balance is below minimum balance' do
# Q. expect(subject.touch_in).to raise_error 'Insufficient balance to touch in'
      expect { subject.touch_in(:entry_station) }. to raise_error 'Insufficient balance - Please top up'
    end
    it 'sets in_journey status to true' do
      subject.top_up(10)
      subject.touch_in(:entry_station)
      expect(subject.in_journey).to be true
# Q.  expect(subject).to be_in_journey
    end
    it 'stores the entry station' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
# Q. Why () ok here?
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to (:touch_out) }
    it 'sets in_journey status to false' do
      subject.top_up(10)
      subject.touch_in(:entry_station)
      subject.touch_out(3)
      expect(subject.in_journey?).to be false
    end
    it 'deducts the fare from the balance' do
      subject.top_up(20)
      subject.touch_in(:entry_station)
      expect{ subject.touch_out(3) }.to change { subject.balance }.by -3
      # expect{ subject.touch_out }.to change { subject.balance }.by(-Oystercard::MIN_CHARGE)
    end
    it 'saves completed journeys' do
      subject.top_up(10)
      subject.touch_in(:entry_station)
      subject.touch_out(3)
    end
  end





end
