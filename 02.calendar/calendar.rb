require 'date'

# 今月の最初
date_first = Date.new(2023, 5, 1)

# 末日
date_last = Date.new(2023, 5, -1)

puts "      #{date_first.month}月 #{date_first.year}"

# 一ヶ月間表示する
weeks = ["日","月","火","水","木","金","土"]
weeks.each do |week|
    if week == "土"
      print week + "\n"
    else 
     print week + " "
    end
end

# 空白で曜日を合わせる
brank = "   "
space = ""
space += brank * date_first.wday
print space

number_of_days = date_last.day # 月の日数を計算する

number_of_days.times do 
    if (1..9) === date_first.day
        print " "
    end
    if date_first.saturday?
        print  date_first.day.to_s + " " +  "\n"
    else
        print  date_first.day.to_s + " "
    end
    date_first += 1
end

# %を表示させないために追加
puts ""