class ChangbaDownloader

  require 'fileutils'
  require 'open-uri'

  LINK_REGEXP = /\{mp3:\"([^"]*?)\"\}/
  TITLE_REGEXP = /<div class=\"pcsong_name\">(.*?)<\/div>/
  AUTHOR_REGEXP = /<a onClick=\"goPersonal[^"]*?\">(.*?)<\/a>/

  def self.download_song(url, out_dir)
    FileUtils.mkdir_p(out_dir)

    page = open(url).read
    page.force_encoding('utf-8')

    link = LINK_REGEXP.match(page)
    title = TITLE_REGEXP.match(page)
    author = AUTHOR_REGEXP.match(page)

    if !link || !title || !author
      puts '未找到歌曲信息'
      return
    end

    link = link[1]
    title = title[1]
    author = author[1]

    puts "正在下载 #{author} - #{title}"

    filename = File.join(out_dir, "#{author} - #{title}.mp3")
    command = "curl --connect-timeout 15 --retry 999 --retry-max-time 0 -C - -# \"#{link}\" -o \"#{filename}\""
    system(command)

  end

end