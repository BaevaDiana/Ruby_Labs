# Продолжение предыдущего задания. 
#Попросить пользователя ввести команду языка ruby. И команду OC. Выполнить команду руби и команду операционной системы.

puts "Напомни,пожалуйста, еще раз как тебя зовут?"
user =  ARGV[0]
name_user = STDIN.gets.chomp
puts "#{name_user},введи,пожалуйста,команду языка Ruby!"
ruby_comm = STDIN.gets.chomp
system "ruby -e \"#{ruby_comm}\""
puts "Вау,спасибо! Давай еще команду операционной системы!"
os_comm = STDIN.gets.chomp
system "#{os_comm}"




