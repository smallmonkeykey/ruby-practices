# frozen_string_literal: true

require 'optparse'

ROWS = 3

def exec_ls_command
  filenames = Dir.glob('*')
  desplay_filenames(filenames)
end

def exec_ls_a_command
  filenames = Dir.entries('.').sort
  desplay_filenames(filenames)
end

def split_files_equally(filenames)
  sliced_filenames = filenames.each_slice((filenames.size.to_f / ROWS).ceil).to_a
  (sliced_filenames[0].size - sliced_filenames.last.size).times { sliced_filenames.last.push(' ') }
  sliced_filenames
end

def transpose_split_files_equally(filenames)
  arry_max_size = filenames.map(&:size).max
  split_files_equally(filenames).transpose.each do |line|
    puts line.map { |file| file.ljust(arry_max_size + 1) }.join
  end
end

def desplay_filenames(filenames)
  split_files_equally(filenames)
  transpose_split_files_equally(filenames)
end

opt = OptionParser.new
opt.on('-a', '--all') { exec_ls_a_command }
opt.parse(ARGV)

exec_ls_command if ARGV.empty?
