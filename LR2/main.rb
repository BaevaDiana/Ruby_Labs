require_relative 'student'

student1 = Student.new('Баев', 'Андрей', 'Николаевич')
student2 = Student.new('Баева', 'Диана', 'Николаевна', { id: 1, telegram: '@pluxurypinkphloydrockstar' })
student3 = Student.new('Иванов', 'Алексей', 'Алексеевич', { phone: '79259511100', email: 'ivanov_alexey_2000@mail.ru', git: '@alexiv' })


puts student1
puts student2
puts student3


puts Student.valid_phone?('79259511100')
puts Student.valid_phone?('+9 1323-122-33-78')

puts Student.valid_acc?('@alexiv')
puts Student.valid_email?('baevadianawrk@gmail.com')

puts student3.git?

student1.set_contacts({telegram: '@user1995'})
puts student1
