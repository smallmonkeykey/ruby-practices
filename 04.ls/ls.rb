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


sort_pwd_dirs = take_dirs.sort

line = 3
NUMBER = 1

quotient = sort_pwd_dirs.size / line
colum = sort_pwd_dirs.size / (quotient + NUMBER)
remainder = sort_pwd_dirs.size % (quotient + NUMBER)

arry = []

if remainder == 0
    arry = sort_pwd_dirs.each_slice(colum).map {|dir| dir }
else
    sort_pwd_dirs.each_slice(quotient + NUMBER).with_index(1) do |dir, idx|
        idx += 1
        arry << dir
        if arry[idex = colum]
            ((quotient + NUMBER) - remainder).times {arry.last.push(" ")}
        end
    end
end

arry.transpose.each do |line|
  puts line.map{|file| file.ljust(24)}.join()
end
