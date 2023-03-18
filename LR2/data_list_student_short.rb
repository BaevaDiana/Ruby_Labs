require_relative 'data_table'

class DataListStudentShort < DataList
  public_class_method :new

  def get_names
    ["short_name", "git", "contact"]
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

  # сеттер для массива объектов
  def table_fields(object)
    [object.short_name, object.git, object.contact]
  end
end







