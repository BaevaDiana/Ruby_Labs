#Принять имя пользователя как аргумент. Поздороваться с пользователем с использованием форматирования строки. 
#Спросить какой язык у пользователя любимый, в случае, если это ruby, ответить что пользователь подлиза, иначе обязательно ответить, что скоро будет ruby и поставить различные комментарии для нескольких  яыков.

#!/user/bin/ruby

user = ARGV[0]
puts "Привет, пользователь! Как тебя зовут?"
name_user = STDIN.gets.chomp
puts "Приятно познакомиться, #{name_user}!."
puts "Любишь программировать?! Ну-ну... Какой твой любимый язык?"

lan_ans =  STDIN.gets.chomp
case lan_ans
	when "ruby"
		puts "Ясно, пользователь-подлиза!"
	when "python"
		puts "Питонистам привет передавай!"
	when "C++"
		puts "Респект!"
	when "C#"
		puts "Ок."
	else
		puts "Скоро будет Ruby..."
end




