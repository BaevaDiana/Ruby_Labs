require_relative '/home/diana/LR3/repositories/data_sources/labs'


class AddLabController
  def initialize(student_lab)
    @student_lab = student_lab
  end

  def add_view(view)
    @view = view
    @view.set_lab
  end
  def execute
    @view.execute
  end
  def save_lab(lab)
    @student_lab.add_lab(lab)
  end

  def next_number_lab
    @student_lab.get_next_number
  end

  def validate_fields(fields)
    begin
      lab = Lab.new(**fields)
      return lab

    rescue ArgumentError => e
      return nil
    end
  end

  def validate_date_range(new_date, lab_id)
    idx_last_date = lab_id.to_i-1
    if idx_last_date>=0
      old_date = @student_lab.get_lab_by_number(idx_last_date).date_start
      return Lab.validate_date_range?(new_date, old_date)
    else
      true
    end
  end



end