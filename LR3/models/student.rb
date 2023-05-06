require 'json'
require_relative 'student_short'

class Student < StudentShort

    # геттеры и сеттеры(стандартные)
    attr_writer :id
    attr_reader :phone, :telegram, :email, :git, :first_name, :surname


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


    # стандартный конструктор
    def initialize(last_name, first_name, surname, id: nil, git: nil, phone: nil, email: nil, telegram: nil)
        self.last_name = last_name
        self.first_name = first_name
        self.surname = surname
        self.id = id
        self.git = git
        set_contacts(phone: phone, email: email, telegram: telegram)
    end


    def self.from_hash(hash)
        raise ArgumentError, 'Missing fields: last_name, first_name, surname' unless hash.key?(:first_name) && hash.key?(:last_name) && hash.key?(:surname)

        first_name = hash.delete(:first_name)
        last_name = hash.delete(:last_name)
        surname = hash.delete(:surname)

        Student.new(last_name, first_name, surname, **hash)
    end

    def to_hash
        attrs = {}
        %i[last_name first_name surname id phone telegram email git].each do |attr|
            attr_val = send(attr)
            attrs[attr] = attr_val unless attr_val.nil?
        end
        attrs
    end

    # конструктор из json-строки
    def self.init_from_json(str)
        params = JSON.parse(str, { symbolize_names: true })
        from_hash(params)
    end

    # сеттеры 
    def first_name=(first_name)
    	raise ArgumentError, "Incorrect value: first_name=#{first_name}!" if !first_name.nil? && !Student.valid_name?(first_name)
        @first_name = first_name
     end

    def last_name=(last_name)
        raise ArgumentError, "Incorrect value: last_name=#{last_name}" if !last_name.nil? && !Student.valid_name?(last_name)
        @last_name = last_name
    end

    def surname=(surname)
        raise ArgumentError, "Incorrect value: paternal_name=#{surname}!" if !surname.nil? && !Student.valid_name?(surname)
        @surname = surname
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


    # фамилия и инициалы студента
    def short_name
        "#{last_name} #{first_name[0]}. #{surname[0]}."
    end

    # краткая информация о студенте
    def getInfo
        "#{short_name}, #{contact}, git=#{git}"
    end


    # установка контакта
    def contact
        return @contact = "phone=#{phone}" unless phone.nil?
        return @contact = "telegram=#{telegram}" unless telegram.nil?
        return @contact = "email=#{email}" unless email.nil?
        nil
    end


    def set_contacts(phone: nil, telegram: nil, email: nil)
        self.phone = phone if phone
        self.telegram = telegram if telegram
        self.email = email if email
        @contact = contact
    end


    # представление объекта в виде строки
    def to_s
        result = "#{last_name} #{first_name} #{surname}"
        result += " id=#{id}" unless id.nil?
        result += " phone=#{phone}" unless phone.nil?
        result += " git=#{git}" unless git.nil?
        result += " telegram=#{telegram}" unless telegram.nil?
        result += " email=#{email}" unless email.nil?
        result
    end


end





