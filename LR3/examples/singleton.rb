#В этом примере мы создали класс SingletonExample и определили метод класса instance, который возвращает единственный экземпляр класса.
#Метод instance проверяет, существует ли уже экземпляр класса. Если экземпляр уже существует, метод возвращает его. Если экземпляр еще не создан, метод создает новый экземпляр и возвращает его.
#Метод new определен как приватный метод с помощью ключевого слова private_class_method, чтобы предотвратить создание новых экземпляров класса извне.

class SingletonExample
  @@instance = nil

  def self.instance
    @@instance ||= SingletonExample.new
  end

  private_class_method :new

  def initialize
    @counter = 0
  end

  def increment_counter
    @counter += 1
  end

  def get_counter_value
    @counter
  end
end

# Вызов объекта:
obj = SingletonExample.instance
obj.increment_counter
puts obj.get_counter_value # => 1


