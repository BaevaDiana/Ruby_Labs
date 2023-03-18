class DataList

  private_class_method :new

  attr_writer :objects_list

  # конструктор
  def initialize(objects)
    self.objects_list = objects
    self.selected_objects = []
  end

  def select(number)
    selected_objects.append(number)
  end

  def clear_select
    self.selected_objects = []
  end

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
    id = 0
    objects_list.each do |obj|
      row = []
      row << id
      # * необходима так как, если нам передадут [1,2,3], то передастся row.push(1,2,3)
      row.push(*table_fields(obj))
      result << row
      id += 1
    end
    DataTable.new(result)
  end

  protected

  def get_names; end

  # метод переопределяется у наследника
  def table_fields(object)
    []
  end
