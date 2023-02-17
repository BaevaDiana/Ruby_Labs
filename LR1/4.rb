# Вариант 1.

# 1.1 Дан целочисленный массив. Необходимо найти количество элементов, расположенных после последнего максимального.
def meth1(array)
	return 0 if array.empty?
	max_index = array.rindex(array.max)
	array.length - max_index - 1
	end


#1.13 Дан целочисленный массив. Необходимо разместить элементы,расположенные до минимального, в конце массива.
def meth2(array)
	min_index = array.index(array.min)
	array.rotate(min_index)
end


# 1.25 Дан целочисленный массив и интервал a..b. Необходимо найти максимальный из элементов в этом интервале.
def meth3(array, a,b)
   array[a..b].max
end


# 1.37 Дан целочисленный массив. Вывести индексы элементов, которые меньше своего левого соседа.
def meth4(array)
	(1..array.length-1).inject([]) do |res,i|
		res << i if array[i]<array[i-1]
		res
  end
end


# 1.49 Для введенного списка положительных чисел построить список всех положительных простых делителей элементов списка без повторений.

# функция определения простоты числа
def prime?(number)
  return false if number <= 1
  return true if number == 2
  Math.sqrt(number).to_int.downto(2).each do |x|
    return false if (number%x) == 0
  end
  true
end

def meth5(array)
	array.inject([]) do |ans, el|
		div = (2..el).inject([]) do |res,i|
			res << i if prime?(i)&& el%i==0
			res
		end
		ans.concat(div).uniq
	end
end


file = ARGV[0]
array = File.open(file) {|file| file.readlines.map(&:to_i)}

puts 'Выберите:'
puts '1. Найти количество элементов, расположенных после последнего максимального.
2. Разместить элементы,расположенные до минимального, в конце массива.
3. Найти максимальный из элементов в этом интервале. (Необходимо ввести интервал)
4. Вывести индексы элементов, которые меньше своего левого соседа, и количество таких чисел.
5. Построить список всех положительных простых делителей элементов списка без повторений.'

method = STDIN.gets.chomp.to_i


case method
  when 1
  	print(meth1(array))

  when 2
    print(meth2(array))

  when 3
    puts 'Введите границы интервала:'
    print"a = "
    a = STDIN.gets.chomp.to_i
    print"b = "
    b = STDIN.gets.chomp.to_i
    if a > b then 
      puts 'Ошибка!Введен неправильный интервал.'
    end
    if b > array.length then
      puts 'Ошибка!Введен неверный интервал.'
    else 
        print(meth3(array,a,b))
    end

  when 4
    print(meth4(array))

  when 5
    print(meth5(array))

  else 
    puts 'Команды с таким номером нет'
end




































