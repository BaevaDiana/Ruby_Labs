require_relative '/home/diana/LR3/controller/crud/change_student_controller.rb'

class ChangeStudentNameController<ChangeStudentController
  public_class_method :new

  def get_editable_fields
    [:last_name, :first_name, :surname]
  end

end