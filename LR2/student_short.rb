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


	# фамилия и инициалы студента
    def short_name
        "#{@last_name} #{@initals}"
    end

    # представление объекта в виде строки
    def to_s
        result = short_name
        result += " id=#{id} " unless id.nil?
        result += contact unless contact.nil?
        result
    end

    # проверка наличия гита
    def git?
        !git.nil?
    end

    # проверка наличия любого из контактов    
    def contact?
        !contact.nil? 
    end

    def validate
        git? && contact?
    end

end




