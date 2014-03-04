class ChangbaDownloader

  require 'fileutils'
  require 'open-uri'

  require_relative 'location_decoder'

  LINK_REGEXP = /\{mp3:\"([^"]*?)\"\}/
  TITLE_REGEXP = /<title>(.*?)<\/title>/
  INFO_REGEXP = /(.*?) - (.*?) 唱吧,最时尚的手机KTV/


  def self.download_song(url, out_dir)
    FileUtils.mkdir_p(out_dir)

    page = open(url).read
    page.force_encoding('utf-8')

    link = LINK_REGEXP.match(page)
    title = TITLE_REGEXP.match(page)
    info = title && INFO_REGEXP.match(title[1])

    if !link || !title || !info
      puts '未找到歌曲信息'
      return
    end

    link = LocationDecoder.decode(link[1])
    name = info[1]
    author = info[2]

    puts "正在下载 #{author} - #{name}"

    filename = File.join(out_dir, "#{author} - #{name}.mp3")
    command = "curl --connect-timeout 15 --retry 999 --retry-max-time 0 -C - -# \"#{link}\" -o \"#{filename}\""
    system(command)

  end

end