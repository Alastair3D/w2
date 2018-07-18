require 'station'

describe Station do
  subject(:station) { Station.new('Bond Street', 1) }
# option 2
  # subject { described_class.new(name: 'Bond Street', zone: 1) }

  describe '#initialize' do
    it 'has name' do
      expect(subject.name).to eq 'Bond Street'
# op 2
      # expect(subject.name).to eq('Bond Street')
    end
    it 'has a zone' do
      expect(subject.zone).to eq(1)
    end
  end

end
