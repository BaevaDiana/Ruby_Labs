require_relative '/home/diana/LR3/view/student_app'
require_relative '/home/diana/LR3/repositories/data_sources/student_list'
require_relative '/home/diana/LR3/repositories/student_list_db'
require_relative '/home/diana/LR3/repositories/containers/data_list_student_short'
require_relative '/home/diana/LR3/repositories/data_sources/student_list_adapter'
require 'mysql2'

class StudentListController
  def initialize(view)
    @view = view
    @data_list = DataListStudentShort.new([])
    @data_list.add_observer(@view)
    @student_list = StudentList.new(StudentsListDB.new)
    file_path = '/home/diana/LR3/tests/students.json'
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

end