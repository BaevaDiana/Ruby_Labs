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


  protected

  def get_names
    raise NotImplementedError, "get_names must be implemented in inheriting class"
  end

  def get_data
    raise NotImplementedError, "get_data must be implemented in inheriting class"
  end


  # метод переопределяется у наследника
  def table_fields(object)
    []
  end
