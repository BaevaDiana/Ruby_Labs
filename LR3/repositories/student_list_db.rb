require 'mysql2'
require_relative '/home/diana/LR3/models/student'
require_relative '/home/diana/LR3/repositories/dbstudents'
require_relative '/home/diana/LR3/repositories/containers/data_list_student_short'


class StudentsListDB

  # новый конструктор
  def initialize
    self.client = DBStudent.instance
  end


  def from_array_to_hash(arr)
    attrs = {}
    i=0
    %i[id last_name first_name surname phone telegram email git].each do |attr|
      attrs[attr] = arr[i] unless arr[i].nil?
      i=i+1
    end
    attrs
  end

  # поиск студента по id
  def student_by_id(student_id)
    hash = client.query("SELECT * FROM students WHERE id = #{student_id}").first
    return Student.from_hash(hash.transform_keys(&:to_sym)) if hash
    nil

  end

  def get_k_n_student_short_list(k,n, data_list)
    students = client.prepare_exec('SELECT * FROM students LIMIT ? OFFSET ?',(k-1)*n,n)
    slice = students.map { |h| StudentShort.new(Student.from_hash(h)) }

    DataListStudentShort.new(slice)
  end

  # добавление студента
  def add_student(student)
    stmt = client.prepare_exec('insert into students (first_name, last_name, surname, phone, telegram, email, git) VALUES (?, ?, ?, ?, ?, ?, ?)', *student_fields(student))
  end

  # удаление студента
  def remove_student(student_id)
    client.prepare_exec('DELETE FROM students WHERE id = ?', student_id)
  end

  # обновление студента
  def replace_student(student_id, student)
    template = 'UPDATE students SET first_name=?, last_name=?, surname=?, phone=?, telegram=?, email=?, git=? WHERE id=?'
    client.prepare_exec(template, *student_fields(student), student_id)

  end

  # количество студентов
  def student_count
    #client.query('SELECT COUNT(id) FROM students').next[0]
    result = client.query('SELECT COUNT(id) FROM students')
    result.each do |row|
      puts row
    end
  end


  private

  attr_accessor :client

  def student_fields(student)
    [student.first_name, student.last_name,  student.surname, student.phone, student.telegram, student.email, student.git]
  end
end

