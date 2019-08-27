require 'oystercard'
describe Oystercard do
  it 'has a default balance of zero' do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum limit of #{maximum_balance} exceeded"
    end
  end

  it { is_expected.to respond_to(:deduct).with(1).argument }

  describe '#deduct' do
    it 'deducts an amount from the balance' do
      subject.top_up(10)
      expect { subject.deduct(3) }.to change{ subject.balance }.by -3
    end
  end
end 
