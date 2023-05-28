pwd_dir = []

Dir.open('.').each_child {|f|
  if File.ftype(f) == "directory"
    pwd_dir << "#{f}/"
  else
  pwd_dir << f 
  end
}

pwd_dir.sort.each_with_index do |n, idx|
  idx += 1
  print n.ljust(24)
  print "\n"  if idx % 3 == 0
 end

puts ""