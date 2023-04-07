require_relative '/home/diana/LR3/models/student'
require_relative '/home/diana/LR3//models/student_short'
require_relative '/home/diana/LR3/repositories/containers/data_list_student_short'
require_relative '/home/diana/LR3/repositories/data_sources/student_list_base'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_txt'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_json'
require_relative '/home/diana/LR3/repositories/data_sources/strategy/student_list_yaml'
require 'json'
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

# Создаем соединение с базой данных
client = Mysql2::Client.new(
  :host => 'localhost',
  :username => 'root',
  :password => 'password',
  :database => 'student_db'
)

# Выполняем SELECT-запрос
results = client.query('SELECT * FROM students')

# Выводим результаты на экран
results.each do |row|
  puts row.inspect
end
