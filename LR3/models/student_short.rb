require 'json'

class StudentShort
  # стандартные геттеры для класса
  attr_reader :id, :git, :contact, :last_name, :initials

  # стандартный конструктор, принимающий аргументов экземпляр класса student
  def initialize(student)
    @id = student.id

    @last_name = student.last_name
    @initials = "#{student.first_name[0]}. #{student.surname[0]}."
    @git = student.git unless student.git.nil?
    @contact = student.set_contacts(phone: student.phone, email: student.email, telegram: student.telegram)
  end

  # кастомный конструктор, принимающий на вход id и строку, которая содержит всю остальную инф-ю
  def self.from_str(id, str)
    result = JSON.parse(str)
    raise ArgumentError, 'Missing fields: last_name, first_name, surname' unless result.key?('first_name') &&
      result.key?('last_name') && result.key?('surname')

    StudentShort.new(Student.new(result['last_name'],result['first_name'],result['surname'],id: id,
                                 phone: result['phone'], git: result['git'],
                                 email: result['email'],telegram: result['telegram']))
  end

  # def self.init_from_student(student)
  #   StudentShort.new(student.id, JSON.generate({"short_name": student.short_name, "phone": student.phone, "telegram": student.telegram, "email": student.email, "git": student.git}))
  # end

  # метод возвращающий фамилию и инициалы у объекта
  def short_name
    "#{@last_name} #{@initials}"
  end

  # метод возвращающий представление объекта в виде строки
  def to_s
    result = short_name
    result += " id= #{id} " unless id.nil?
    result += contact unless contact.nil?
    result
  end

  # метод проверяющий наличие гита
  def git?
    !git.nil?
  end

  # метод проверяющий наличие контакта
  def contact?
    !contact.nil?
  end

  def validate
    git? && contact?
  end

end