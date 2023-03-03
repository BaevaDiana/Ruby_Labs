class Student
    #конструктор 
    def initialize(last_name,first_name,surname,options={})
        self.id = options[:id]
        self.last_name = last_name
        self.first_name = first_name
        self.surname = surname
        self.phone = options[:phone]
        self.telegram = options[:telegram]
        self.email = options[:email]
        self.git = options[:git]
       end

      # геттеры и сеттеры(стандартные)
      attr_accessor:id
      attr_reader:first_name, last_name, surname, phone, telegram, email,git








