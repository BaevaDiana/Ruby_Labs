
class StudentListBase

  attr_writer :data_type

  # конструктор
  def initialize(data_type)
    self.students = []
    self.cur_id = 1
    self.data_type = data_type
  end

  # загрузка из файла
  def load_from_file(file_path)
    list = data_type.str_to_list(File.read(file_path))
    self.students = list.map { |h| Student.from_hash(h) }
    update_cur_id
  end

  # выгрузка в файл
  def save_to_file(file_path)
    list = students.map(&:to_hash)
    File.write(file_path, data_type.list_to_str(list))
  end

  # поиск студента по id
  def student_by_id(student_id)
    students.detect { |s| s.id == student_id }
  end

  # поиск студента по фамилии и инциалам
  def student_by_name(student_name)
    students.filter { |s| s.short_name == student_name }
  end

  # Получить page по счету count элементов (страница начинается с 1)
  def get_k_n_student_short_list(page, count, current_data_list)
    offset = (page - 1) * count # сдвиг элементов массива
    slice = students[offset, count].map { |s| StudentShort.new(s) }

    return DataListStudentShort.new(slice) if current_data_list.nil?

    current_data_list.append(slice)
  end

  # #полуение n элементов page страницы
  # def get_k_n_student_short_list(page, n, data_list)
  #   page_list = students[(page-1)*n, n].map{|st| StudentShort.init_from_student(st)}
  #   return DataListStudentShort.new(page_list) if data_list.nil?
  #   data_list.replace_objects(page_list)
  #   data_list
  # end


  # сортировка
  def sorted
    students.sort_by(&:short_name)
  end

  # добавление студента
  def add_student(student)
    student.id = cur_id
    students << student
    self.cur_id += 1
  end

  # замена студента
  def replace_student(student_id, student)
    idx = students.find_index { |s| s.id == student_id }
    students[idx] = student
  end

  # удаление студента
  def remove_student(student_id)
    students.reject! { |s| s.id == student_id }
  end

  # число студентов
  def student_count
    students.size
  end

  protected

  attr_accessor :students, :cur_id

  private

  attr_reader :data_type

  # метод для обновлении информации в cur_id
  def update_cur_id
    self.cur_id = students.max_by(&:id).id.to_i + 1
  end

end