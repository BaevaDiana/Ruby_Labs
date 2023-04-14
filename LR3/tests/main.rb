require_relative '/home/diana/LR3/models/student'
require_relative '/home/diana/LR3//models/student_short'
require_relative '/home/diana/LR3/repositories/containers/data_list_student_short'
require_relative '/home/diana/LR3/repositories/data_sources/student_list_base'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_txt'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_json'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_yaml'
require_relative '/home/diana/LR3/repositories/dbstudents'
require_relative '/home/diana/LR3/repositories/student_list_db'
require_relative '/home/diana/LR3/repositories/data_sources/student_list'
require_relative '/home/diana/LR3/repositories/data_sources/student_list_adapter'
require_relative '/home/diana/LR3/repositories/data_sources/student_list_base'
require 'mysql2'

# def read_from_txt(file_path)
#   raise ArgumentError, 'File not found' unless File.exist?(file_path)

#   stud_file = File.open(file_path, 'r'
#   result = ''
#   stud_file.each do |line|
#     result << line
#   end
#   stud_file.close
#   students_list = []
#   stud_list = JSON.parse(result)

#   stud_list['StudentList'].each do |obj|
#     students_list << Student.init_from_json(obj.to_json)
#   end
#   students_list
# end

# def write_to_txt(file_path, student_list)
#   result = '{"StudentList":['
#   student_list.each do |student|
#     result += student.to_json + ","
#   endru
#   result = result.chop + "]}"
#   File.write(file_path, result)
# end

# #student1 = Student.new('Баева', 'Диана', 'Николаевна')
# #student2 = Student.new('Баев', 'Андрей', 'Николаевич',  id: 1, telegram: '@baev_andrey' )
# #student3 = Student.new('Иванов', 'Алексей', 'Алексеевич',  phone: '79181461800', email: 'alexiv@gmail.com', git: '@alexiv' )


# #student_list = [student1, student2, student3]

# #puts read_from_txt('/home/diana/students_list.txt')
# #write_to_txt('/home/diana/new_students_list.txt', student_list)

# test = [ [1,'One'], [2,'Two']]
# test_table = DataTable.new(test)
# puts test_table
# puts test_table.get_elements(0,1)


# student1 = Student.new('Баева', 'Диана', 'Николаевна')
# student2 = Student.new('Шатохин', 'Артем', 'Вячеславович', id:1, telegram: '@shah_ayo')
# student3 = Student.new('Голубин', 'Глеб', 'Геннадьевич',  phone: '79181461800', email: 'gol_gleb@gmail.com', git: '@ggleb')
#
#
# puts '--------------------------------'
# puts 'Тест StudentsList (JSON):'
#
#
# stud_list_json = StudentListBase.new(StudentListJSON.new)
# stud_list_json.add_student(student1)
# stud_list_json.add_student(student2)
# stud_list_json.add_student(student3)
# stud_list_json.save_to_file('/home/diana/LR3/tests/students.json')
#
# stud_list_json.load_from_file('/home/diana/LR3/tests/students.json')
#
# puts "Успешно записано и прочитано #{stud_list_json.student_count} студентов:"
#
# puts '--------------------------------'
# puts 'Тест StudentsList (YAML):'
#
# stud_list_yaml = StudentListBase.new(StudentListYAML.new)
# stud_list_yaml.add_student(student1)
# stud_list_yaml.add_student(student2)
# stud_list_yaml.add_student(student3)
# stud_list_yaml.save_to_file('/home/diana/LR3/tests/students.yaml')
#
#
#
# puts "Успешно записано и прочитано #{stud_list_yaml.student_count} студентов:"
#
#
# puts '--------------------------------'
# puts 'Тест StudentsList (TXT):'
#
# stud_list_txt = StudentListBase.new(StudentListTxt.new)
# stud_list_txt.add_student(student1)
# stud_list_txt.add_student(student2)
# stud_list_txt.add_student(student3)
# stud_list_txt.save_to_file('/home/diana/LR3/tests/students.txt')

# stud_list_txt.load_from_file('/home/diana/LR3/tests/students.txt')
#
# puts "Успешно записано и прочитано #{stud_list_txt.student_count} студентов:"

# создаем соединение с базой данных
# client = Mysql2::Client.new(
#   :host => 'localhost',
#   :username => 'root',
#   :password => 'password',
#   :database => 'student_db'
# )
#
# # тестирование
# db = StudentsListDB.new
# student = Student.new('Голубин', 'Глеб', 'Геннадьевич', phone: '79698876534' )
# db.add_student(student)
# puts db.student_by_id(3)
# puts db.student_count
#
# # выполняем SELECT-запрос
# results = client.query('SELECT * FROM students')
#
# # выводим результаты на экран
# results.each do |row|
#   puts row.inspect
# end
def test_adapter(student_rep)
  puts "В репозитории #{student_rep.student_count} студентов."
  puts "Студент с id=1: #{student_rep.student_by_id(1)}"
  student_rep.remove_student(2)
  puts "Теперь в репозитории #{student_rep.student_count} студента."
  student = Student.new('Девин', 'Эдвенна', 'Аоки',  id: 1, telegram: '@suki' )
  added_id=student_rep.add_student(student)
  puts "Теперь в репозитории #{student_rep.student_count} студентов."
  student.git = '@suuki'
  puts student.to_s

  student_rep.replace_student(1,student)
  puts "Измененный студент: #{student_rep.student_by_id(3)}"
  puts 'Страница 1:'
  student_rep.get_k_n_student_short_list(1,3).get_data.inspect
end

puts '=> Тест StudentRepository (JSON) <='
rep_json =StudentList.new(StudentListAdapter.new(StudentListJSON.new, '/home/diana/LR3/tests/students.json'))
test_adapter(rep_json)
