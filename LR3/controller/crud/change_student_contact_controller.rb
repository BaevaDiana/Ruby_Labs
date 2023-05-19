require_relative '/home/diana/LR3/controller/crud/change_student_controller.rb'

class ChangeStudentContactController<ChangeStudentController
  public_class_method :new
  def get_editable_fields
    [:phone, :telegram, :email]
  end

end