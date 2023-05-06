# Паттерн Наблюдатель определяет отношение «один-ко-многим» между объектами таким образом,
# что при изменении состояния одного объекта происходит автоматическое оповещение и обновление всех зависимых объектов

# Класс, который извещает своих наблюдателей о своем состоянии
class Subject
  attr_reader :state # Атрибут для хранения состояния

  def initialize(state)
    @state = state # Инициализируем состояние
    @observers = [] # Создаем пустой массив для хранения наблюдателей
  end

  def add_observer(observer)
    @observers << observer # Добавляем наблюдателя в массив
  end

  def delete_observer(observer)
    @observers.delete(observer) # Удаляем наблюдателя из массива
  end

  def notify_observers
    @observers.each do |observer| # Для каждого наблюдателя в массиве
      observer.update(self) # Вызываем метод update, передавая себя в качестве аргумента
    end
  end

  def change_state(new_state)
    @state = new_state # Изменяем состояние
    notify_observers # Оповещаем наблюдателей
  end
end

# Класс, который наблюдает за состоянием другого объекта
class Observer
  def update(subject) # Метод, который вызывается при оповещении
    puts "Observer: Subject's state is #{subject.state}" # Выводим состояние субъекта
  end
end

# Создаем объекты субъекта и наблюдателя
subject = Subject.new("initial")
observer = Observer.new

# Добавляем наблюдателя к субъекту
subject.add_observer(observer)

# Изменяем состояние субъекта и наблюдаем за реакцией наблюдателя
subject.change_state("changed")