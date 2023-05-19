require_relative '/home/diana/LR3/view/student_app'
require_relative '/home/diana/LR3/repositories/data_sources/student_list'
require_relative '/home/diana/LR3/repositories/student_list_db'
require_relative '/home/diana/LR3/repositories/containers/data_list_student_short'
require_relative '/home/diana/LR3/repositories/data_sources/student_list_adapter'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_json'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_yaml'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_txt'
require_relative '/home/diana/LR3/controller/crud/create_student_controller'
require_relative '/home/diana/LR3/view/create_student_dialog'
require_relative '/home/diana/LR3/models/student'
require_relative '/home/diana/LR3/controller/crud/change_student_contact_controller'
require_relative '/home/diana/LR3/controller/crud/change_student_git_controller'
require_relative '/home/diana/LR3/controller/crud/change_student_name_controller'
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

  # добавление студента
  def student_add
    controller = AddStudentController.new(@student_list)
    show_dialog(controller)
  end

  public
  def student_change(index, controller_type)
    @data_list.select(index)
    id = @data_list.get_select
    @data_list.clear_selected

    controller = controller_type.new(@student_list, id)
    show_dialog(controller)
  end

  def student_change_name(index)
    puts 'update name'
    student_change(index, ChangeStudentNameController)
  end


  def student_change_git(index)
    puts 'update git'
    student_change(index, ChangeStudentGitController)
  end

  def student_change_contact(index)
    puts 'update contact'
    student_change(index, ChangeStudentContactController)
  end

  def student_delete(indexes)
    @data_list.select(*indexes)
    id_list = @data_list.get_select
    @data_list.clear_selected

    id_list.each{|student_id| @student_list.remove_student(student_id)}
    @view.refresh
  end

  # открытие модального окна
  def show_dialog(controller)
    view = CreateStudentDialog.new(@view, controller)
    controller.add_view(view)
    controller.execute

    @view.refresh
  end




end