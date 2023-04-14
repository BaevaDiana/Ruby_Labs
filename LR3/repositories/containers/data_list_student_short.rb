require_relative '/home/diana/LR3/repositories/containers/data_list'
require_relative '/home/diana/LR3/repositories/containers/data_table'
class DataListStudentShort < DataList
  
  public_class_method :new

  # переопределение метода из предка
  def get_names
    ["short_name", "git", "contact"]
  end


  def get_data
      result = []
      id = 0
      objects_list.each do |obj|
        row = []
        row << id
        row.push(*table_fields(obj))
        result << row
        id += 1
      end
      DataTable.new(result)
  end

  protected

  # применение паттерна Шаблон

  # сеттер для массива объектов
  def table_fields(object)
    [object.short_name, object.git, object.contact]
  end

end







