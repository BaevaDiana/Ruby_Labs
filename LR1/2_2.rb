#Вариант 1

#Метод 2.
#Найти количество нечетных цифр числа, больших 3

def meth2(number)
	count = 0
	while number > 0
		if number%10%2 > 0 &&  number%10 > 3
			count += 1
		end
		number /= 10
	end
	count
end



puts "Введите число:"
n = STDIN.gets.to_i
puts "Количество нечётных цифр числа, больших 3 у числа #{n} = #{meth2(n)}"