
# Адаптируемый класс
class Adaptee
  def specific_request
    'Adaptee specific request'
  end
end

# Адаптер
class Adapter
  def initialize(adaptee)
    @adaptee = adaptee
  end

  def request
    @adaptee.specific_request
  end
end

# Клиентский код
adaptee = Adaptee.new
adapter = Adapter.new(adaptee)
puts adapter.request # => 'Adaptee specific request'

# Класс Adapter реализует интерфейс, который ожидается клиентами, и использует объект класса Adaptee для выполнения запросов.
# В клиентском коде создаются объекты классов Adaptee и Adapter, а затем вызывается метод request у объекта класса Adapter. 
# Этот метод вызывает метод specific_request у объекта класса Adaptee, который выполняет необходимые действия.