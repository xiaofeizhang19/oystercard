require 'oystercard'

describe Oystercard, :aggregate_failures do
  let(:entry_station) { instance_double('Station') }
  let(:exit_station) { instance_double('Station') }

  def touch_in
    subject.touch_in(entry_station)
  end

  def touch_out
    subject.touch_out(exit_station)
  end

  it 'has a default balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum limit of #{maximum_balance} exceeded"
    end
  end

  def top_up_and_touch_in
    subject.top_up(5)
    touch_in
  end

  describe '#touch_in' do
    it 'raises error if balance less than 1' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      expect { touch_in }.to raise_error "Minimum balance #{minimum_balance} required"
    end

    it 'deducts penalty if not touched out' do
      subject.top_up(10)
      touch_in
      penalty = Oystercard::PENALTY_CHARGE
      expect { touch_in }.to change { subject.balance }.by(-penalty)
    end

    it 'puts oystercard in use' do
      top_up_and_touch_in
      expect(subject.in_journey?).to be(true)
    end
  end

  describe '#touch_out' do
    it 'puts oystercard not in use' do
      top_up_and_touch_in
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to be(false)
    end

    it 'deduct the balance by minimum fare' do
      top_up_and_touch_in
      expect { touch_out }.to change { subject.balance }.by(-1)
    end

    it 'deducts penalty if touched out' do
      penalty = Oystercard::PENALTY_CHARGE
      expect { touch_out }.to change { subject.balance }.by(-penalty)
    end

    it 'should not store journey if touched out' do
      touch_out
      expect(subject.journeys).to be_empty
    end

    it 'should store journey' do
      top_up_and_touch_in
      subject.touch_out(exit_station)
      journeys = subject.journeys

      expect(journeys.size).to be 1
      expect(journeys.first.entry_station).to eq entry_station
      expect(journeys.first.exit_station).to eq exit_station
    end 
  end
end