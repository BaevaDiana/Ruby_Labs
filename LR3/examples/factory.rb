class Creator
  def factory_method
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteCreator1 < Creator
  def factory_method
    ConcreteProduct1.new
  end
end

class ConcreteCreator2 < Creator
  def factory_method
    ConcreteProduct2.new
  end
end

class Product
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteProduct1 < Product
  def operation
    'ConcreteProduct1'
  end
end

class ConcreteProduct2 < Product
  def operation
    'ConcreteProduct2'
  end
end

def client_code(creator)
  puts "Client: I'm not aware of the creator's class, but it still works.\n"\
       "#{creator.some_operation}"
end

puts "App: Launched with the ConcreteCreator1."
client_code(ConcreteCreator1.new)
puts "\n\n"

puts "App: Launched with the ConcreteCreator2."
client_code(ConcreteCreator2.new)

# В этом примере класс Creator объявляет фабричный метод (factory_method), который должен возвращать объект класса Product2.
# Классы ConcreteCreator1 и ConcreteCreator2 реализуют этот метод и возвращают соответствующие объекты классов ConcreteProduct1 и ConcreteProduct22.
# Классы Product, ConcreteProduct1 и ConcreteProduct2 представляют собой иерархию продуктов.