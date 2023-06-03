# frozen_string_literal: true

def take_dirs
  pwd_dirs = []
  Dir.open('.').each_child do |file|
    if file == ".gitignore" || file == ".git" || file == ".rubocop.yml"
     next
    end
    pwd_dirs << if File.ftype(file) == 'directory'
                  "#{file}/"
                else
                  file
                end
  end
  pwd_dirs
end

NUMBER = 1
LINE = 5

def make_arry
sort_pwd_dirs = take_dirs.sort

quotient = sort_pwd_dirs.size / LINE
colum = sort_pwd_dirs.size / (quotient + NUMBER)
remainder = sort_pwd_dirs.size % (quotient + NUMBER)

arry = []

  if (sort_pwd_dirs.size % LINE).zero?
    arry = sort_pwd_dirs.each_slice(quotient).map { |dir| dir }
  else
    sort_pwd_dirs.each_slice(quotient + NUMBER) do |dir|
      arry << dir
      ((quotient + NUMBER) - remainder).times { arry.last.push(' ') } if arry[colum]
    end
    arry
  end
end

make_arry.transpose.each do |line|
  puts line.map{|file| file.ljust(24)}.join()
end
