require_relative 'symbols'
require_relative 'code'

class Parser
  A_COMMAND = 'A_COMMAND'
  LABEL = 'LABEL'
  C_COMMAND = 'C_COMMAND'

  attr_reader :file_path, :file, :total_lines,
    :current_line, :file_array, :out_file,
    :out_path

  def initialize(options)
    setup_vars(options)
    open_file
    remove_comments
    @total_lines = file_array.length
  end

  def setup_vars(options)
    @file_path = options[:file_path]
    @out_path = @file_path.sub('asm', 'hack')
  end

  def open_file
    @file = File.open(file_path, 'r')
    @out_file = File.open(out_path, 'wb')
    @current_line = 0
    @file_array = file.readlines
    @file.close
  end

  def current_command
    file_array[current_line]
  end

  def advance
    if has_more_commands?
      @current_line = @current_line + 1
    end
  end

  def has_more_commands?
    current_line + 1 <= total_lines
  end

  def command_type(command)
    case command[0]
    when '@'
      return A_COMMAND
    when '('
      return LABEL
    else
      return C_COMMAND
    end
  end

  def parse_file
    while has_more_commands?
      hack_code = convert(current_command)
      write_to_file(hack_code)
      advance
    end
    out_file.close
  end

  def convert(command)
    case command_type(command)
    when A_COMMAND
      puts "find #{command}"
      return  Symbols.find(command)
    when LABEL
      puts "Label search #{command}"
      return Symbols.find(command)
    when C_COMMAND
      puts "Code convert "#{command}"
      return Code.to_binary(command)
    end
  end

  def write_to_file(hack_code)
    return unless hack_code
    out_file.puts hack_code
  end

  private

  def remove_comments
    @file_array = @file_array.select { |l| line_of_code?(l.strip!) }
  end

  def line_of_code?(line)
    (line.length > 0) && !line.index('//')
  end

end
