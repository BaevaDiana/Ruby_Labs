require 'mysql2'
require_relative '/home/diana/LR3/controller/crud/create_student_controller'

class ChangeStudentController<AddStudentController

  private_class_method :new
  def initialize(student_list, student_id)
    super(student_list)
    @student_id = student_id
  end

  def add_view(view)
    super(view)
    student = @student_list.student_by_id(@student_id)
    @view.set_student(student, get_editable_fields)
  end

  def save_student(student)
    @student_list.replace_student(@student_id, student)
  end

  private
  def get_editable_fields; end
end