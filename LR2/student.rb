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

    # сеттер
    def first_name=(first_name)
    	raise ArgumentError, "Incorrect value: first_name=#{first_name}!" if !first_name.nil? && !Student.valid_name?(first_name)
        @first_name = first_name
     end

    def last_name=(last_name)
        raise ArgumentError, "Incorrect value: last_name=#{last_name}!" if !last_name.nil? && !Student.valid_name?(last_name)
        @last_name = last_name
    end

    def surname=(surname)
        raise ArgumentError, "Incorrect value: paternal_name=#{paternal_name}!" if !paternal_name.nil? && !Student.valid_name?(paternal_name)
        @paternal_name = paternal_name
    end

    def phone=(phone)
        raise ArgumentError, "Incorrect value: phone=#{phone}!" if !phone.nil? && !Student.valid_phone?(phone)
        @phone = phone
    end

    def telegram=(telegram)
        raise ArgumentError, "Incorrect value: telegram=#{telegram}!" if !telegram.nil? && !Student.valid_account?(telegram)
        @telegram = telegram
    end

    def email=(email)
        raise ArgumentError, "Incorrect value: email=#{email}!" if !email.nil? && !Student.valid_email?(email)
        @email = email
    end

    def git=(git)
    	raise ArgumentError, "Incorrect value: git=#{git}!" if !git.nil? && !Student.valid_account?(git)
    	@git = git
    end








