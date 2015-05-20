require_relative '../lib/parser.rb'

describe Parser do
  context 'test add' do
    before do
      @in_path = '../add/Add.asm'
      @p = Parser.new(file_path: @in_path)
    end
    it { expect(@p.file_path).to eq(@in_path) }

    it 'should remove comments' do
      expect(@p.total_lines).to eq(6)
    end

    it 'should return the current command' do
      expect(@p.file_array[0]).to eq(@p.current_command)
    end

    it 'should advance' do
      @p.advance
      expect(@p.current_line).to eq(1)
      expect(@p.file_array[1]).to eq(@p.current_command)
    end

    it 'should not pass the eof' do
      6.times do
        @p.advance
      end
      expect(@p.has_more_commands?).to eq(false)
    end

    it 'should recognize a label' do
      expect(@p.command_type('@r1')).to eq('A_COMMAND')
    end

    it 'should recognize an a command' do
      expect(@p.command_type('(LABEL)')).to eq('LABEL')
    end

    it 'should recognize a c command' do
      expect(@p.command_type('dest=A+1;jmp')).to eq('C_COMMAND')
    end

  end
end
