require_relative '/home/diana/LR3/labs_controller/add_lab_controller'

class ChangeLabController<AddLabController
  def initialize(student_lab, id_lab)
    super(student_lab)
    @lab_number = id_lab
  end

  def add_view(view)
    @view = view
    lab = @student_lab.get_lab_by_number(@lab_number)
    @view.set_lab(lab)
  end

  def save_lab(lab)
    @student_lab.replace_lab(@lab_number, lab)
  end
end
