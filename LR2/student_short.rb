require 'json'


class Student_short

	# геттеры(стандартные)
	attr_reader :id, :last_name, :initials, :git, :contact

	# конструктор, у которого аргумент - объект класса Student
	def initialize(student)
		@id = student.id
		@last_name = student.last_name
		@initials = "#{student.first_name[0]}. #{student.surname[0]}."
		@git = student.git unless student.git.nil?
		@contact = student.contact
	end

	# констуктор с аргументами id и строка со всей остальной информацией
	def self.from_student(id,str)
		result = JSON.parse(str)
		raise ArgumentError, 'Missing fields: last_name, first_name, surname' unless result.key?('first_name') &&result.key?('last_name') && result.key?('surname')

		Student_Short.new(Student.new(result['last_name'],result['first_name'],result['surname'],id: id,phone: result['phone'],git: result['git'], telegram: result['telegram']))
	end


