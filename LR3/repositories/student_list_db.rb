require 'mysql2'
require_relative '/home/diana/LR3/models/student'
require_relative '/home/diana/LR3/repositories/dbstudents'


class StudentsListDB

  # новый конструктор
  def initialize
    self.client = DBStudent.instance
  end

  # поиск студента по id
  def student_by_id(student_id)
    hash = client.prepare_exec('SELECT * FROM students WHERE id = ?',student_id).first
    print(hash)
    return nil if hash.nil?

    Student.from_hash(hash)

  end

  def get_k_n_student_short_list(k,n)
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

# тестирование
db = StudentsListDB.new
student = Student.new('Голубин', 'Глеб', 'Геннадьевич', phone: '79698876534' )
db.add_student(student)
puts db.student_count