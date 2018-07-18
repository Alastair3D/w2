require 'station'


describe Station do
  subject(:station) { Station.new('Bond Street', 1) }
  # subject(:station) { described_class.new('Bond Street', 1) }

  describe '#initialize' do
    it 'has name' do
      expect(station.name).to eq 'Bond Street'
      # expect(subject.name).to eq 'Bond Street'
    end
  end

end
