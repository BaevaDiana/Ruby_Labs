require_relative '/home/diana/LR3/view/student_app'
require_relative '/home/diana/LR3/repositories/data_sources/student_list'
require_relative '/home/diana/LR3/repositories/student_list_db'
require_relative '/home/diana/LR3/repositories/containers/data_list_student_short'

class StudentListController
  def initialize(view)
    @view = view
    @data_list = DataListStudentShort.new([])
    @data_list.add_observer(@view)
  end

  def on_view_create
    @student_list = StudentList.new(StudentListDB.new)
  end

  def show_view
    @view.create.run
  end

  def refresh_data(k_page, number_students)
    @data_list = @student_list.get_k_n_student_short_list(k_page, number_students, @data_list)
    @view.update_count_students(@student_list.student_count)
  end
end