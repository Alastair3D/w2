require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }
  # subject(:card) {described_class.new(journey_class: journey_class)}
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
# Translate this.  Syntax options for doubles.
  # let(:max_balance) { Oystercard::MAX_BALANCE}
  # let(:default_balance) { Oystercard::DEFAULT_BALANCE }
  # let(:min_balance) { Oystercard::MIN_BALANCE }
  # let(:fare) { 1 }
  # before { allow(journey_class).to receive(:new).and_return(journey)}
  # let(:journey_log) { double :journey_log }

  describe '#initialize' do
    it 'defaults balance to £0.00 when no params present' do
      expect(subject.balance).to eq 0.00
    end
  # how can I refactor below?
    # it 'allows variable balance to be passed in' do
    #   o1 = Oystercard.new(50)
    #   expect(o1.balance).to eq 50.00
    # end
    it 'is not in a journey' do
      expect(subject).not_to be_in_journey
    end
    it 'has an empty list of journeys by default' do
      expect(subject.journey).to be_empty
    end
  end

  describe '#top-up' do
    it 'can be topped up' do
      expect(subject.top_up(25)).to eq 25
    end
    it 'raises error if maximum balance is exceeded' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Error - maximum balance of #{maximum_balance} exceeded"
    end
# why does this test not pass?  fail vs. raise_error.. () Vs. {} + PRY
  end

  describe '#touch_in' do
    # it { is_expected.to respond_to (:touch_in) }
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it 'raises error if balance below minimum limit' do
# expect(subject.touch_in).to raise_error 'Insufficient balance to touch in'
      expect { subject.touch_in(:entry_station) }. to raise_error 'Insufficient balance - Please top up'
    end
    context 'after touching in' do
      before do
        subject.top_up(10)
        subject.touch_in(entry_station)
      end
    it 'starts a journey' do
      expect(subject.in_journey).to be true
# Q.  expect(subject).to be_in_journey
    end
    it 'stores entry station' do
      expect(subject.entry_station).to eq entry_station
# Q. Why () ok here?
    end
  end
end

  describe '#touch_out' do
    it { is_expected.to respond_to (:touch_out) }
    context 'after touching in' do
    before do
      subject.top_up(10)
      subject.touch_in(:entry_station)
    end
      it 'sets in_journey status to false' do
        subject.touch_out(3)
        expect(subject.in_journey?).to be false
      end
      it 'deducts fare from balance' do
        expect{ subject.touch_out(:exit_station) }.to change { subject.balance }.by -2
        # expect{ subject.touch_out }.to change { subject.balance }.by(-Oystercard::MIN_CHARGE)
      end
    end
    context 'after touching out' do
      before do
        subject.top_up(10)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      end
        it 'stores exit station' do
          expect(subject.exit_station).to eq exit_station
        end
      end
    end

    describe '#history' do
    # Explain let below & why passing in 'undoubled' entry and exit station to touchin/out
    # when to use : and when not e.g. 103 and 104 work with :entry_station
      let(:journey) { {entry: entry_station, exit: exit_station} }
        before do
          subject.top_up(10)
          subject.touch_in(entry_station)
          subject.touch_out(exit_station)
        end
        it 'saves completed journeys' do
          expect(subject.journey).to include journey
        end
        it 'adds journey to history' do
          expect(subject.history).to include journey
        end
    end

end
