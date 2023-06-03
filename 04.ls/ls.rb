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

def make_arry
sort_pwd_dirs = take_dirs.sort

line = 2

quotient = sort_pwd_dirs.size / line
colum = sort_pwd_dirs.size / (quotient + NUMBER)
remainder = sort_pwd_dirs.size % (quotient + NUMBER)

p sort_pwd_dirs.size
p quotient
p colum

arry = []

if sort_pwd_dirs.size % line == 0
    arry = sort_pwd_dirs.each_slice(quotient).map {|dir| dir }
else
    sort_pwd_dirs.each_slice(quotient + NUMBER).with_index(1) do |dir, idx|
        idx += 1
        arry << dir
        if arry[idex = colum]
            ((quotient + NUMBER) - remainder).times {arry.last.push(" ")}
        end
    end
  arry
end
end

p make_arry

make_arry.transpose.each do |line|
  puts line.map{|file| file.ljust(24)}.join()
end
