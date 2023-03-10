require 'json'
require_relative 'student_short'

class Student< Student_Short

    # геттеры и сеттеры(стандартные)
    attr_accessor:id
    attr_reader:first_name, :last_name, :surname, :phone, :telegram, :email,:git


    # валидатор телефонного номера
    def self.valid_phone?(phone)
        phone.match(/^\+?[7,8] ?\(?\d{3}\)?-?\d{3}-?\d{2}-?\d{2}$/)
    end

    # валидатор ФИО
    def self.valid_name?(name)
        name.match(/^[А-Я][а-я]+$/)
    end

    # валидатор телеграмма и гита
    def self.valid_acc?(account)
        account.match(/^@[A-Za-z0-9\-_]+$/)
    end

    # валидатор почты
    def self.valid_email?(email)
        email.match(/^[A-Za-z0-9\-_]+@[A-Za-z]+\.([A-Za-z]+\.)*[A-Za-z]+$/)
    end


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

    # конструктор из json-строки
    def self.init_from_json(str)
        result = JSON.parse(str)
        raise ArgumentError, 'Missing fields: last_name, first_name, surname' unless result.key?('first_name') && result.key?('last_name') && result.key?('surname')
        last_name = result.delete('last_name')
        first_name = result.delete('first_name')
        surname = result.delete('surame')
        Student.new(last_name, first_name, surname, **result.transform_keys(&:to_sym))
    end


    # сеттеры 
    def first_name=(first_name)
    	raise ArgumentError, "Incorrect value: first_name=#{first_name}!" if !first_name.nil? && !Student.valid_name?(first_name)
        @first_name = first_name
     end

    def last_name=(last_name)
        raise ArgumentError, "Incorrect value: last_name=#{last_name}!" if !last_name.nil? && !Student.valid_name?(last_name)
        @last_name = last_name
    end

    def surname=(surname)
        raise ArgumentError, "Incorrect value: paternal_name=#{surname}!" if !surname.nil? && !Student.valid_name?(surname)
        @paternal_name = surname
    end

    def phone=(phone)
        raise ArgumentError, "Incorrect value: phone=#{phone}!" if !phone.nil? && !Student.valid_phone?(phone)
        @phone = phone
    end

    def telegram=(telegram)
        raise ArgumentError, "Incorrect value: telegram=#{telegram}!" if !telegram.nil? && !Student.valid_acc?(telegram)
        @telegram = telegram
    end

    def email=(email)
        raise ArgumentError, "Incorrect value: email=#{email}!" if !email.nil? && !Student.valid_email?(email)
        @email = email
    end

    def git=(git)
    	raise ArgumentError, "Incorrect value: git=#{git}!" if !git.nil? && !Student.valid_acc?(git)
    	@git = git
    end

 
    # проверка наличия гита
    def git?
        !git.nil?
    end

    # проверка наличия любого из контактов    
    def contact?
        !email.nil? || !phone.nil? || !telegram.nil?
    end

    def validate
        git? && contact?
    end


    # установка значений полей для введенных контактов
    def set_contacts(contacts)
        self.phone = contacts[:phone] if contacts.key?(:phone)
        self.telegram = contacts[:telegram] if contacts.key?(:telegram)
        self.email = contacts[:email] if contacts.key?(:email)
    end
    def to_s
        result = "#{last_name} #{first_name} #{surname}"
        result += " id=#{id}" unless id.nil?
        result += " phone=#{phone}" unless phone.nil?
        result += " git=#{git}" unless git.nil?
        result += " telegram=#{telegram}" unless telegram.nil?
        result += " email=#{email}" unless email.nil?
        result
    end


    # фамилия и инициалы студента
    def short_name
        "#{last_name} #{first_name[0]}. #{surname[0]}."
    end


    # краткая информация о студенте
    def getInfo
        "#{short_name}, #{contact}, git=#{git}"
    end

    # контакт
    def contact
        return "phone=#{phone}" unless phone.nil?
        return "telegram=#{telegram}" unless telegram.nil?
        return "email=#{email}" unless email.nil?
        nil
    end


end





