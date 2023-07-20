# frozen_string_literal: true

require 'optparse'
require 'etc'

opt = OptionParser.new
params = {}
opt.on('-l') { |v| v }

opt.parse!(ARGV, into: params)

def determine_option(params)
  params[:l] ? exec_ls_l_command : exec_ls_command
end

ROWS = 3

def chunk_filenames(filenames)
  sliced_filenames = filenames.each_slice((filenames.size.to_f / ROWS).ceil).to_a
  (sliced_filenames[0].size - sliced_filenames.last.size).times { sliced_filenames.last.push(' ') }
  sliced_filenames
end

def display_filenames(filenames)
  arry_max_size = filenames.map(&:size).max
  chunk_filenames(filenames).transpose.each do |line|
    puts line.map { |file| file.ljust(arry_max_size + 1) }.join
  end
end

def exec_ls_command
  filenames = Dir.glob('*')
  display_filenames(filenames)
end

def convert_filetypes(filetype)
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

def display_ls_l_command(filenames)
  filenames.each do |filename|
    filetype = File.ftype(filename)
    filetype_result = convert_filetypes(filetype)

    stat = File.stat(filename)
    filemode = stat.mode.to_s(8)
    permission_result = determine_permissions(filemode)

    hard_link = stat.nlink.to_s.rjust(3)

    owner = Etc.getpwuid(stat.uid).name
    group = Etc.getgrgid(stat.gid).name

    file_size = stat.size.to_s.rjust(6)

    time = stat.mtime.strftime('%_m %_d %H:%M')

    print "#{filetype_result}#{permission_result}#{hard_link} #{owner}  #{group}#{file_size} #{time} #{filename}\n"
  end
end

def exec_ls_l_command
  filenames = Dir.glob('*')
  display_ls_l_command(filenames)
end

determine_option(params)
