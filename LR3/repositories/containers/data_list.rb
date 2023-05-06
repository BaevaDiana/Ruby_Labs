class DataList

  private_class_method :new

  attr_writer :objects_list

  # конструктор
  def initialize(objects_list)
    self.objects_list = objects_list
    self.selected_objects = []
    @observers = []
  end

  # паттерн Наблюдатель
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

  # получить выделенные объекты(массив)
  # def get_selected
  #   return [] if selected_objects.empty?
  #
  #   selected_id_list = []
  #   selected_objects.each do |num|
  #     selected_id_list.append(objects_list[num].id)
  #   end
  #   selected_id_list
  # end
  def get_select
    objects_list[selected_objects].id
  end

  def get_names; end

  # применение паттерна Шаблон
  def get_data
    index_id=0
    dt = objects_list.inject([]) do |res, object|
      row=[index_id]
      row.append(*get_fields(object))
      index_id+=1
      res<<row
    end
    DataTable.new(dt)
  end

  def replace_objects(objects_list)
    self.objects_list = objects_list.dup
    notify
  end

  protected
  attr_reader :objects_list
  attr_accessor :selected_objects


  # теперь этот метод необходимо переопределять у наследников
  def get_fields(object)
    []
  end


end