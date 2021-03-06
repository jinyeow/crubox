require "http/client"

module UpOrDown
  extend self

  ISUP_URL = "http://downforeveryoneorjustme.com"

  def is_down?(url)
    !is_up?(url)
  end

  def is_up?(url)
    res = HTTP::Client.get(ISUP_URL + "/#{url}")
    case res.status_code
    when 200 then res.body.includes? "is up"
    else
      puts "#{res.status_code}: #{ISUP_URL} is unavailable."
    end
  end

  def version
    "1.0.0"
  end
end
