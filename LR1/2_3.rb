#Вариант 1

#Метод 3.
#Найти произведение таких делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа.

#функция поиска суммы цифр
def sum_digits(number)
	sum = 0
	while number > 0
		sum += number%10
		number /= 10
	end
	sum
end

def meth3(num)
	mul = 1
	1.upto(num) do |i|
		if num%i == 0 && sum_digits(i) < sum_digits(num)
			mul*=i
		end
	end
	mul
end


puts "Введите число:"
n = STDIN.gets.to_i
puts "Результат = #{meth3(n)}"



