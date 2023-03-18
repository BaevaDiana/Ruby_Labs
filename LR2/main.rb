require_relative 'student'
require_relative 'student_short'
require_relative 'data_table'

def read_from_txt(file_path)
  raise ArgumentError, 'File not found' unless File.exist?(file_path)

  stud_file = File.open(file_path, 'r')
  result = ''
  stud_file.each do |line|
    result << line
  end
  stud_file.close
  students_list = []
  stud_list = JSON.parse(result)

  stud_list['StudentList'].each do |obj|
    students_list << Student.init_from_json(obj.to_json)
  end
  students_list
end

def write_to_txt(file_path, student_list)
  result = '{"StudentList":['
  student_list.each do |student|
    result += student.to_json + ","
  end
  result = result.chop + "]}"
  File.write(file_path, result)
end

#student1 = Student.new('Баева', 'Диана', 'Николаевна')
#student2 = Student.new('Баев', 'Андрей', 'Николаевич',  id: 1, telegram: '@baev_andrey' )
#student3 = Student.new('Иванов', 'Алексей', 'Алексеевич',  phone: '79181461800', email: 'alexiv@gmail.com', git: '@alexiv' )


#student_list = [student1, student2, student3]

#puts read_from_txt('/home/diana/students_list.txt')
#write_to_txt('/home/diana/new_students_list.txt', student_list)

test = [ [1,'One'], [2,'Two']]
test_table = DataTable.new(test)
puts test_table
puts test_table.get_elements(0,1)