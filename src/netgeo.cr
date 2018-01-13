require "http/client"
require "json"
require "option_parser"

VERSION = "0.4.0"

OptionParser.parse! do |parser|
  parser.banner = "Usage: #{PROGRAM_NAME} [OPTIONS]"

  parser.on("-w", "--wan", "Returns WAN IP") do
    begin
      url = "https://api.ipify.org"
      response = HTTP::Client.get(url)
      puts response.body
    rescue e
      puts "#{e}"
      exit 1
    end
  end

  parser.on("-l", "--lan", "Returns LAN IP(s)") do
    # TODO
    # lans = 
    # puts lans.join(", ")
  end

  parser.on("-r", "--router", "Returns Router IP") do
    if `uname` =~ /Linux/
      router = `ip route | grep default | head -1 | awk '{print $3}'`
    else
      puts "OS not supported."
      exit 1
    end
    puts router
  end

  parser.on("-d", "--dns", "Returns DNS Nameserver") do
    if `uname` =~ /Linux/
      dns = `cat /etc/resolv.conf | grep nameserver | head -1 | awk '{print $2}'`
    else
      puts "OS not supported."
      exit 1
    end
    puts dns
  end

  # TODO: custom/specific geodata

  parser.on("-g", "--geo", "Returns current IP geodata") do
    url  = "http://ip-api.com/json/"
    res  = HTTP::Client.get(url)
    info = JSON.parse(res.body)
    puts info["query"]
    puts info["city"]
    puts info["region"]
    puts info["country"]
    puts info["zip"]
    puts info["isp"]
  end

  parser.on("-h", "--help", "Shows this message") do
    puts parser
    exit
  end

  parser.on("-v", "--version", "Shows version information") do
    puts "v#{VERSION}"
    exit
  end
end
