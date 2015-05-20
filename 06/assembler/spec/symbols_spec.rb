require_relative '../lib/symbols'

describe Symbols do

  context 'default symbols' do
    it { expect(Symbols.find('@R0')).to eq(('%016b'% 0)) }
  end
end
