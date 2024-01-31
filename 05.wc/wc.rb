require 'optparse'
opt = OptionParser.new

params = {:l=>false, :w=>false, :c=>false}

opt.on('-l') {|v| v }
opt.on('-w') {|v| v }
opt.on('-c') {|v| v }

opt.parse!(ARGV, into: params)

def main(params)
    params = {:l=>true, :w=>true, :c=>true} if params == {:l=>false, :w=>false, :c=>false}
    filenames = ARGV
    filenames.empty? ? display_input_content_count : display_filenames_count(filenames,params)
end

def count_lines(filename)
  File.read(filename).count("\n")
end

def count_words(filename)
  File.read(filename).split(/\s+|\t+|\n+/).size
end

def count_bytes(filename)
  FileTest.size(filename)
end

def print_count_result(filenames, params)
   filenames.map do |filename|
   print "#{count_lines(filename).to_s.rjust(8)}" if params[:l]
   print "#{count_words(filename).to_s.rjust(8)}" if params[:w]
   print "#{count_bytes(filename).to_s.rjust(8)}" if params[:c]
   print " #{filename}\n"
   end
end

def print_total(filenames, params)
  lines_total = 0
  words_total = 0
  bytes_total = 0

  filenames.map do |filename|
    lines_total += count_lines(filename) if params[:l]
    words_total += count_words(filename) if params[:w]
    bytes_total += count_bytes(filename) if params[:c]
  end
  puts "#{lines_total.to_s.rjust(8)}#{words_total.to_s.rjust(8)}#{bytes_total.to_s.rjust(8)} total"
end

def display_input_content_count
  input_contents = $stdin.read
  puts "#{input_contents.count("\n").to_s.rjust(8)}#{input_contents.split(/\s+|\t+|\n+/).size.to_s.rjust(8)}#{input_contents.bytesize.to_s.rjust(8)}"
end

def display_filenames_count(filenames,params)
     print_count_result(filenames, params)
     print_total(filenames, params) if ARGV.count > 1
end

main(params)
