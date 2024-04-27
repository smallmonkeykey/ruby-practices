# frozen_string_literal: true

class FileInformation
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

  def calc_block
    File.stat(@filename).blocks
  end

  def build_stat
    {
      type: find_type,
      mode: find_mode,
      nlink: @stat.nlink.to_s,
      owner: Etc.getpwuid(@stat.uid).name,
      group: Etc.getgrgid(@stat.gid).name,
      filesize: @stat.size.to_s,
      time: find_time,
      filename: @filename
    }
  end

  def find_type
    @stat.directory? ? 'd' : '-'
  end

  def find_mode
    permissions = @stat.mode.to_s(8).slice(-3, 3).to_i.digits.reverse
    permissions.map { |permission| MODE_TABLE[permission] }.join
  end

  def find_time
    today = Time.now
    half_year_ago = today - 24 * 60 * 60 * 180

    if @stat.mtime < half_year_ago
      @stat.mtime.strftime('%_m %_d  %Y')
    else
      @stat.mtime.strftime('%_m %_d %H:%M')
    end
  end
end
