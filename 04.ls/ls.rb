def get_dirs
  pwd_dirs = []
  Dir.open('.').each_child {|file|
    if File.ftype(file) == "directory"
      pwd_dirs << "#{file}/"
    else
      pwd_dirs << file
    end
  }
  pwd_dirs
end

sort_pwd_dirs = get_dirs.sort

def fill_up(sort_pwd_dirs, number)
  number - (sort_pwd_dirs.size.modulo(number))
end

quotient = sort_pwd_dirs.size.div(3)
columns = quotient + 1

arry = []
sort_pwd_dirs.each_slice(columns).with_index(1) do |dir, idx|
  arry << dir
  if idx == quotient 
    fill_up(sort_pwd_dirs, 3).times {arry.last.push("")}
  end
end

reversed_array = arry.transpose

reversed_array.each do |line|
  puts line.map{|file| file.ljust(24)}.join()
end
