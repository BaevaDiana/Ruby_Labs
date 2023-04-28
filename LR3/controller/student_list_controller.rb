require_relative '/home/diana/LR3/view/student_app'
require '/home/diana/LR3/data_sources/student_list'
require '/home/diana/LR3/data_sources/student_list_db'

class StudentListController
  def initialize(view)
    @view = view
  end

  def view_create
    @student_list = StudentList.new(StudentListDB.new)
  end

  def show_view
    @view.create.run
  end
end