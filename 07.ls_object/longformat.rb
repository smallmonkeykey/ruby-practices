# frozen_string_literal: true

require 'etc'

class LongFormat
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

  def initialize(filenames)
    @filenames = filenames
  end

  def list_files
    puts "total #{total_block}"

    @filenames.each do |filename|
      stat = File.stat(filename)
      puts create_file_info(stat, filename)
    end
  end

  def create_file_info(stat, filename)
    print "#{format_type(stat)}#{format_mode(stat)} "
    print "#{build_stat(filename)[:nlink].rjust(find_max_size[:nlink] + 1)} "
    print build_stat(filename)[:owner].ljust(find_max_size[:owner] + 1)
    print "#{build_stat(filename)[:group].rjust(find_max_size[:group] + 1)} "
    print build_stat(filename)[:filesize].rjust(find_max_size[:filesize] + 1)
    print "#{build_stat(filename)[:time].rjust(find_max_size[:time] + 1)} "
    print build_stat(filename)[:filename]
  end

  def total_block
    @filenames.map { |filename| File.stat(filename).blocks }.sum
  end

  def format_type(file_stat)
    file_stat.directory? ? 'd' : '-'
  end

  def format_mode(stat)
    permissions = stat.mode.to_s(8).slice(-3, 3).to_i.digits.reverse
    permissions.map { |permission| MODE_TABLE[permission] }.join
  end

  def build_stat(filename)
    stat = File.stat(filename)
    {
      type: format_type(stat),
      mode: format_mode(stat),
      nlink: stat.nlink.to_s,
      owner: Etc.getpwuid(stat.uid).name,
      group: Etc.getgrgid(stat.gid).name,
      filesize: stat.size.to_s,
      time: stat.mtime.strftime('%_m %_d %H:%M'),
      filename:
    }
  end

  def find_max_size
    {
      nlink: @filenames.map { |filename| build_stat(filename)[:nlink].size }.max,
      owner: @filenames.map { |filename|  build_stat(filename)[:owner].size }.max,
      group: @filenames.map { |filename|  build_stat(filename)[:group].size }.max,
      filesize: @filenames.map { |filename| build_stat(filename)[:filesize].size }.max,
      time: @filenames.map { |filename| build_stat(filename)[:time].size }.max
    }
  end
end
