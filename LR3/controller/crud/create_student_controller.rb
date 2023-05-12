require 'mysql2'
require_relative '/home/diana/LR3/models/student'
class AddStudentController

  def initialize(student_list)
    @student_list = student_list
  end

  #привязка view
  def add_view(view)
    @view = view
  end

  def execute
    @view.execute
  end

  def save_student(student)
    @student_list.add_student(student)
  end


  def validate_fields(fields)
    begin
      student = Student.new(**fields)
      return student

    rescue ArgumentError => e
      return nil
    end
  end


end