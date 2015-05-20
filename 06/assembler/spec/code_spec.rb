require_relative '../lib/code'

describe Code do
  it 'should spile commands' do
    pieces = Code.split_command('D=D+A')
    expect(pieces[:cmd]).to eq('D+A')
    expect(pieces[:dest]).to eq('D')
    expect(pieces[:jump]).to eq(nil)
  end

  it 'should translate commands' do
    b_c = Code.command('D|M')
    expect(b_c).to eq('1010101')
  end

  it 'should translate the jump' do
    jc = Code.jump('JEQ')
    expect(jc).to eq('010')
  end

  it 'should translate a command' do
    c = Code.to_binary('M=1')
    expect(c).to eq('1110111111001000')
  end
end
