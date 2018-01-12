require "option_parser"

require "./crubox/up_or_down"

OptionParser.parse! do |parser|
  parser.banner = <<-BANNER
  Utility to check the status of a website.

  Usage:
    #{PROGRAM_NAME} [url]
  BANNER

  parser.separator("")

  parser.on("-h", "--help", "Show this message.") { puts parser; exit }
  parser.on("-v", "--version", "Show version information.") {
    puts "v#{UpOrDown.version}"
    exit
  }
end

if ARGV.size > 0
  if UpOrDown.is_up? ARGV.first
    puts "#{ARGV.first} is up"
  else
    puts "#{ARGV.first} is down"
  end
end
