require './lib/journey'

describe Journey do
  let(:entry_station) { instance_double('Station') }
  let(:exit_station) { instance_double('Station') }

  def stop
    subject.stop(exit_station)
  end

  def start
    subject.start(entry_station)
  end

  describe '#start' do
    it 'should start' do
      start
      expect(subject.in_progress?).to be true
    end

    it 'should store entry station' do
      start
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#stop' do
    it 'should stop' do
      start
      stop
      expect(subject.in_progress?).to be false
    end

    it 'should store exit station' do
      start
      stop
      expect(subject.exit_station).to eq exit_station
    end
  end


end