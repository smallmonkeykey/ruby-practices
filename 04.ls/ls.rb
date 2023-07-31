# frozen_string_literal: true

require 'optparse'
require 'etc'

opt = OptionParser.new
params = {}
opt.on('-a') { |v| v }
opt.on('-r') { |v| v }
opt.on('-l') { |v| v }

opt.parse!(ARGV, into: params)

ROWS = 3

def chunk_filenames(filenames)
  sliced_filenames = filenames.each_slice((filenames.size.to_f / ROWS).ceil).to_a
  (sliced_filenames[0].size - sliced_filenames.last.size).times { sliced_filenames.last.push(' ') }
  sliced_filenames
end

def show_short_format(filenames)
  arry_max_size = filenames.map(&:size).max
  chunk_filenames(filenames).transpose.each do |line|
    puts line.map { |file| file.ljust(arry_max_size + 1) }.join
  end
end

def convert_filetype(filetype)
  {
    'file' => '-',
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'link' => 'l'
  }[filetype]
end

def convert_permissions(filemode_number)
  {
    0 => '---',
    1 => '--x',
    2 => '-w-',
    3 => '-wx',
    4 => 'r--',
    5 => 'r-x',
    6 => 'rw-',
    7 => 'rwx'
  }[filemode_number]
end

def determine_permissions(filemode)
  last_three_digits = filemode.to_i % 1000
  last_three_digits_arry = last_three_digits.digits.reverse

  permission = last_three_digits_arry.map { |digit| convert_permissions(digit) }
  permission.join('')
end

def sum_blocks(filenames)
  filename_blocks = filenames.map do|filename| 
    stat = File.stat(filename)
    stat.blocks
  end
  total_blocks = filename_blocks.sum
  puts  "total #{total_blocks}"
end

def show_long_format(filenames)
  filenames.each do |filename|
    filetype = File.ftype(filename)
    filetype_result = convert_filetype(filetype)

    stat = File.stat(filename)

    filemode = stat.mode.to_s(8)
    permission_result = determine_permissions(filemode)

    hard_link = stat.nlink.to_s.rjust(3)

    owner = Etc.getpwuid(stat.uid).name
    group = Etc.getgrgid(stat.gid).name

    file_size = stat.size.to_s.rjust(6)

    time = stat.mtime.strftime('%_m %_d %H:%M')

    puts "#{filetype_result}#{permission_result}#{hard_link} #{owner}  #{group}#{file_size} #{time} #{filename}"
  end
end

filenames = Dir.glob('*')
filenames = Dir.entries('.').sort if params[:a]
filenames = filenames.reverse if params[:r]

if params[:l]
  sum_blocks(filenames)
  show_long_format(filenames)
else
  show_short_format(filenames)
end
