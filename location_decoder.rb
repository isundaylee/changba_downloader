class LocationDecoder

  def self.decode(url)
    regex = /userwork\/([abc])(\d+)\/(\w+)\/(\w+)\.mp3/
    match = regex.match(url)

    if match
      _, a, b, c, d = match.to_a[0...5]

      b = b.oct
      c = c.hex / b / b
      d = d.hex / b / b

      if (a == 'a' && d % 1000 == k)
        "http://a#{f}mp3.changba.com/userdata/userwork/#{c}/#{d}.mp3"
      else
        if (a == 'c')
          "http://aliuwmp3.changba.com/userdata/userwork/#{d}.mp3"
        else
          url
        end
      end
    else
      url
    end
  end

end