require_relative '/home/diana/LR3/repositories/data_sources/labs'
require_relative '/home/diana/LR3/repositories/containers/data_list_lab'
require_relative '/home/diana/LR3/repositories/student_list_db'
require_relative '/home/diana/LR3/repositories/dbstudents'
require_relative '/home/diana/LR3/labs_controller/student_lab_controller'
class StudentLab
  def initialize
    self.db = DBStudent.instance
  end

  def get_lab_by_number(id_lab)
    id_lab = Array(id_lab)
    result = @db.query("SELECT * FROM labs WHERE id = #{id_lab.first.to_i}")
    hash = result.first
    puts hash
    return nil if hash.nil?
    Lab.new(**hash.transform_keys(&:to_sym))
  end


  def add_lab(lab)
    @db.prepare_exec('insert into labs (id, name, date_start, themes, tasks) VALUES (?, ?, ?, ?, ?)', *lab_fields(lab))
  end
  # добавление студента
  def add_student(student)
    @client.prepare_exec('insert into students (last_name, first_name, surname, phone, telegram, email, git) VALUES (?, ?, ?, ?, ?, ?, ?)', *student_fields(student))
  end

  def remove_lab(id_lab)
    db.query("DELETE FROM labs WHERE id= #{id_lab}")
  end


  def replace_lab(id_lab, lab)
    fields = *lab_fields(lab)
    name = fields[1].nil? ? 'NULL' : fields[1]
    date_start = fields[2].nil? ? 'NULL' : "'#{fields[2]}'"
    themes = fields[3].nil? ? 'NULL' : fields[3]
    tasks = fields[4].nil? ? 'NULL' : fields[4]

    db.query("UPDATE labs SET name = '#{name}',
                             date_start = #{date_start},
                             themes = '#{themes}',
                             tasks = '#{tasks}'
                             WHERE id = #{id_lab.first.to_i}")
  end




  def get_lab_list(data_list=nil) #получение все лаб в базе
    labs_hash = db.query('SELECT * FROM labs')
    labs = labs_hash.map{|lab| Lab.new(**lab.transform_keys(&:to_sym))}
    return DataListStudentLab.new(labs) if data_list.nil?
    data_list.replace_objects(labs)
    data_list
  end

  def get_next_number
    lab_count+1
  end

  def lab_count
    res=db.query('SELECT COUNT(id) FROM labs').first.values.first
    res
  end

  private
  attr_accessor :db
  def lab_fields(lab)
    [lab.id, lab.name, lab.date_start, lab.themes, lab.tasks]
  end
end