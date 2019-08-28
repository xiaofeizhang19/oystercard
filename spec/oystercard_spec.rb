require 'oystercard'

describe Oystercard do
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
    subject.touch_in(at: '')
  end

  describe '#touch_in' do
    it 'raises error if balance less than 1' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      expect { subject.touch_in('') }.to raise_error "Minimum balance #{minimum_balance} required"
    end

    it 'puts oystercard in use' do
      top_up_and_touch_in
      expect(subject.in_journey?).to be(true)
    end

    it 'should store entry station' do
      subject.top_up(5)
      subject.touch_in('station')
      expect(subject.station).to eq 'station'
    end
  end

  describe '#touch_out' do
    it 'puts oystercard not in use' do
      top_up_and_touch_in
      subject.touch_out
      expect(subject.in_journey?).to be(false)
    end

    it 'deduct the balance by minimum fare' do
      top_up_and_touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(-1)
    end
  end
end