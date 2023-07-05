# frozen_string_literal: true
require 'optparse'

opt = OptionParser.new
params = {}
opt.on('-a') { |v| v }

opt.parse!(ARGV, into: params) 

def get_the_file_name(params)
    if params[:a]
      Dir.entries('.').sort
    else 
        filenames = Dir.glob("*")
    end
end

filenames = get_the_file_name(params)

ROWS = 3

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

def exec_ls_command(filenames)
    split_files_equally(filenames)
    transpose_split_files_equally(filenames)
end

exec_ls_command(filenames)
