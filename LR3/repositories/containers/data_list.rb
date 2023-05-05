class DataList

  private_class_method :new

  attr_writer :objects_list

  # конструктор
  def initialize(objects)
    self.objects_list = objects
    self.selected_objects = []
    @observers = []
  end

  # добавление наблюдателя
  def add_observer(observer)
    @observers.append(observer)
  end

  def notify
    @observers.each { |observer| observer.on_datalist_changed(get_data) }
  end

  # добавить id в выборку
  def select(number)
    selected_objects.append(number)
  end

  # очистить массив выборки
  def clear_select
    self.selected_objects = []
  end

  # получить выделенные объекты
  def get_selected
    return [] if selected_objects.empty?

    selected_id_list = []
    selected_objects.each do |num|
      selected_id_list.append(objects_list[num].id)
    end
    selected_id_list
  end

  # применение паттерна Шаблон
  def get_data
    result = []
    ind = 0
    objects_list.each do |obj|
      row = []
      row << ind
      # * необходима так как, если нам передадут [1,2,3], то передастся row.push(1,2,3)
      row.push(*table_fields(obj))
      result << row
      ind += 1
    end
    DataTable.new(result)
  end

  def replace_objects(obj_list)
    self.objects_list=obj_list.dup
    notify
  end

  protected

  # реализуется в наследниках
  def get_names; end

  # теперь этот метод необходимо переопределять у наследников
  def table_fields(object)
    []
  end

  private

  attr_reader :objects_list
  attr_accessor :selected_objects

end