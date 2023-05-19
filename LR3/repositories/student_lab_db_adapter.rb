class StudentLabDbAdapter
  def initialize
    self.db =DBConnection.instance
  end

  def get_lab_by_id(id_lab); end
  def add_lab(lab); end
  def remove_lab(id_lab);end
  def replace_lab(id_lab, lab); end
  def get_lab_list; end #получение все лаб в базе
end