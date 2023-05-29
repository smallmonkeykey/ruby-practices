pwd_dirs = []

Dir.open('.').each_child {|file|
  if File.ftype(file) == "directory"
    pwd_dirs << "#{file}/"
  else
    pwd_dirs << file
  end
}

new_pwd_dirs = pwd_dirs.sort

remainder = new_pwd_dirs.size.modulo(3)
space = 3 - remainder

quotient = new_pwd_dirs.size.div(3)
columns = quotient + 1

arry = []
new_pwd_dirs.each_slice(columns).with_index(1) do |dir, idx|
  arry << dir
  if idx == quotient 
    space.times {arry.last.push("99")}
  end
end

reversed_array = arry.transpose

reversed_array.each do |line|
  puts line.map{|file| file.ljust(24)}.join()
end