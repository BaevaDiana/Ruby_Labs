require_relative 'data_table'

class DataListStudentShort < DataList
  public_class_method :new

  def get_names
    ["short_name", "git", "contact"]
  end

  protected

  def table_fields(object)
    [object.last_name_and_initials, object.git, object.contact]
  end
end







