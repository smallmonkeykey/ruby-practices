require 'date'
require 'optparse'

params = ARGV.getopts("y:m:")

year = params["y"].to_i
month = params["m"].to_i

# コマンドオプションがない時
a = Date.today
this_year = a.year
this_month = a.month

year = this_year if year.zero?
month = this_month if month.zero?

# 今月の最初
date_first = Date.new(year, month, 1)

# 末日
date_last = Date.new(year, month, -1)

puts "      #{date_first.month}月 #{date_first.year}"

# 曜日の行を作成する
puts ["日","月","火","水","木","金","土"].join(" ")

# 空白で曜日を合わせる
print "   " * date_first.wday

(date_first..date_last).each do |date|
  day = date.day.to_s.rjust(2)
  if date.saturday?
    print  "#{day}  \n"
  else
    print  "#{day} "
  end
end

# %を表示させないために追加
puts ""
