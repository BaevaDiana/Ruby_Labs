require 'mysql2'
require_relative '/home/diana/LR3/models/student'
require 'logger'

class AddStudentController

  def initialize(student_list)
    @student_list = student_list
    @logger = Logger.new('controller_add.log') # Указывает путь и имя файла для логов
  end

  #привязка view
  def add_view(view)
    @view = view
  end

  def execute
    @view.execute
    @logger.info('Executing add student operation')
  end

  def save_student(student)
    @logger.info('Saving student')
    @student_list.add_student(student)
  end


  def validate_fields(fields)
    @logger.info('Validating fields')
    required_fields = [:last_name, :first_name, :surname] # список обязательных полей
    if required_fields.all? { |field| fields.key?(field) }
      student = Student.new(
        fields[:last_name],
        fields[:first_name],
        fields[:surname],
        id: fields[:id] || nil,
        phone: fields[:phone] || nil,
        email: fields[:email] || nil,
        telegram: fields[:telegram] || nil,
        git: fields[:git] || nil
      )
      puts(student)
      return student
    else
      return nil
    end
  rescue ArgumentError => e
    @logger.error("Error occurred while validating fields: #{e.message}")
    return nil
  end

end