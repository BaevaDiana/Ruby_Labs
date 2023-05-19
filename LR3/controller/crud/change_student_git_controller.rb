require_relative '/home/diana/LR3/controller/crud/change_student_controller.rb'


class ChangeStudentGitController<ChangeStudentController
  public_class_method :new
  def get_editable_fields
    [:git]
  end

end