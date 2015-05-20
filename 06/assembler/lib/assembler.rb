require 'thor'
require_relative 'parser'

class Assembler < Thor
 desc 'Parser', 'Parses a asm file to hack'
 def parse(file)
  p = Parser.new(file_path: file)
  p.parse_file
 end
end

Assembler.start(ARGV)
