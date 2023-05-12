require_relative '/home/diana/LR3/view/student_app'
require_relative '/home/diana/LR3/repositories/data_sources/student_list'
require_relative '/home/diana/LR3/repositories/student_list_db'
require_relative '/home/diana/LR3/repositories/containers/data_list_student_short'
require_relative '/home/diana/LR3/repositories/data_sources/student_list_adapter'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_json'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_yaml'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_txt'
require_relative '/home/diana/LR3/controller/create_student_controller'
require_relative '/home/diana/LR3/view/create_student_dialog'
require 'mysql2'
require 'fox16'
include Fox

class StudentListController
  def initialize(view)
    @view = view
    @data_list = DataListStudentShort.new([])
    @data_list.add_observer(@view)
    @student_list = StudentList.new(StudentsListDB.new)
    file_path = '/home/diana/LR3/tests/students.yaml'
    # @student_list = StudentList.new(StudentListAdapter.new(StudentListYAML.new, file_path))
  end

  def refresh_data(k_page, number_students)
    begin
      @data_list = @student_list.get_k_n_student_short_list(k_page, number_students, @data_list)
      client = Mysql2::Client.new(
        host: 'localhost',
        username: 'root',
        password: 'password',
        database: 'student_db'
      )

      results = client.query(
        "SELECT * FROM students LIMIT #{(k_page - 1) * number_students}, #{number_students}"
      )
      client.close
    rescue Mysql2::Error => e
      puts "No connection to DB: #{e.message}"
      exit(false)
    end
    @view.update_count_students(@student_list.student_count)
  end

  def show_add_dialog
    add_controller = CreateStudentController.new(self)
    add_view = CreateStudentDialog.new(@view, add_controller)
    add_controller.add_view(add_view)
    add_view.execute

  end

end