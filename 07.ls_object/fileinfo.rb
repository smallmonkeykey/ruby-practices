# frozen_string_literal: true

class File_Information
  MODE_TABLE = {
    0 => '---',
    1 => '--x',
    2 => '-w-',
    3 => '-wx',
    4 => 'r--',
    5 => 'r-x',
    6 => 'rw-',
    7 => 'rwx'
  }.freeze

  def initialize(filename)
    @filename = filename
    @stat = File.stat(filename)
  end

  def build_stat
    {
      type: format_type,
      mode: format_mode,
      nlink: @stat.nlink.to_s,
      owner: Etc.getpwuid(@stat.uid).name,
      group: Etc.getgrgid(@stat.gid).name,
      filesize: @stat.size.to_s,
      time: find_time(@stat),
      filename: @filename
    }
  end

  def format_type
    @stat.directory? ? 'd' : '-'
  end

  def format_mode
    permissions = @stat.mode.to_s(8).slice(-3, 3).to_i.digits.reverse
    permissions.map { |permission| MODE_TABLE[permission] }.join
  end

   def find_time(stat)
    today = Time.now
    half_year_ago = today - 24 * 60 * 60 * 180

    if stat.mtime < half_year_ago
      stat.mtime.strftime('%_m %_d  %Y')
    else
      stat.mtime.strftime('%_m %_d %H:%M')
    end
  end
end
