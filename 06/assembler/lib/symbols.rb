class Symbols
  @@symbols = {
    'SP'=> 0,
    'LCL'=> 1,
    'ARG'=> 2,
    'THIS'=> 3,
    'THAT'=> 4,
    'R0'=> 0,
    'R1' => 1,
    'R2'=> 2,
    'R3'=> 3,
    'R4'=> 4,
    'R5'=> 5,
    'R6'=> 6,
    'R7'=> 7,
    'R8'=> 8,
    'R9'=> 9,
    'R10'=> 10,
    'R11'=> 11,
    'R12'=> 12,
    'R13'=> 14,
    'R15'=> 15,
    'SCREEN'=> 16384,
    'KBD'=> 24567
  }

  @@next_var = 16

  def self.find(to_find)
    string = to_find.sub('@', '')
    symbol = @@symbols[string]
    if(symbol)
      return to_binary(symbol)
    end
    to_binary(string)
  end

  def self.to_binary(int)
    ('%016b' % int)
  end

  def add_symbol(sym, var=nil)
    return if @@symbols.has_key sym
    if var
      @@sybols[sym] == var
    else
      @@symbols[sym] = @@next_var
      @@next_var++
    end
  end
end
