# Массивы.

# 1. Написать методы, которые находят минимальный элемент, номер первого положительного элемента. 
# Каждая операция в отдельном методе. Решить задачу с помощью циклов(for и while).

# 2.Написать программу, которая принимает как аргумент два значения. 
# Первое значение говорит, какой из методов задачи выполнить, второй говорит о том, откуда читать список. Aргументом должен быть написан адрес файла. 
# Далее необходимо прочитать массив и выполнить метод.

def min_arr(array)
	return nil if array.empty?
	min = array[0]
	for i in array
		if i < min
			min = i
		end
	end
	min
end



def find_index(array)
	return false if array.empty?
	n = 0
	for i in array
		if i>0
			return n
		end
		n += 1
	end
	-1
end

methods = %i[min_arr find_index]
method = ARGV[0]
meth = method.to_i
path = ARGV[1]


file = File.open(path)
array = file.readline.split(' ').map(&:to_i)

puts "Массив: #{array}"
puts "Результат работы метода: #{method(methods[meth]).call(array)}"













