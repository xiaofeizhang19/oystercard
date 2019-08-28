require './lib/station'

describe Station do
  subject { Station.new('Aldgate East', '1') }

  it 'should store its name' do
    expect(subject.name).to eq 'Aldgate East'
  end

  it 'should store its zone' do
    expect(subject.zone).to eq '1'
  end

end