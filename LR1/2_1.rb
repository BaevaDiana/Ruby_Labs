#Вариант 1

#Метод 1.
#Найти сумму простых делителей числа.


# функция определения простоты числа
def prime(number)
  return false if number <= 1
  return true if number == 2
  Math.sqrt(number).to_int.downto(2).each do |x|
    return false if (number%x) == 0
  end
  true
end

#сумма простых делителей числа
def sum_prime_dig(number)
  sum = 0
  2.upto(number) do |i|
    if prime(i) && number%i == 0
      sum += i
    end
  end
  sum
end


puts "Введите число:"
n = STDIN.gets.to_i
puts "Сумма простых делителей числа #{n}: #{sum_prime_dig(n)}"




