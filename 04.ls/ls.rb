# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
params = {}
opt.on('-a') { |v| v }

opt.parse!(ARGV, into: params)

def get_filenames(params)
  if params[:a]
    Dir.entries('.').sort
  else
    Dir.glob('*')
  end
end

ROWS = 3

def chunk_filenames(filenames)
  sliced_filenames = filenames.each_slice((filenames.size.to_f / ROWS).ceil).to_a
  (sliced_filenames[0].size - sliced_filenames.last.size).times { sliced_filenames.last.push(' ') }
  sliced_filenames
end

def view_filenames(filenames)
  arry_max_size = filenames.map(&:size).max
  chunk_filenames(filenames).transpose.each do |line|
    puts line.map { |file| file.ljust(arry_max_size + 1) }.join
  end
end

def exec_ls_command(params)
  filenames = get_filenames(params)
  view_filenames(filenames)
end

exec_ls_command(params)
