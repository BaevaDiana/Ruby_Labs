require_relative '/home/diana/LR3/repositories/containers/data_list'
require_relative '/home/diana/LR3/repositories/containers/data_table'

class DataListStudentLab<DataList
  public_class_method :new

  protected
  def get_fields(object)
    [object.id, object.name, object.date_start]
  end

end