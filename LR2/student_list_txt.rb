require_relative 'student_list_strategy'
require 'json'

class StudentListTxt < StudentListStrategy
  public_class_method :new


  #преобразование строки в лист
  def str_to_list(str)
    transform_to_hashes(str.split("\n").map(&:chomp))
  end

   #преобразование списка в строку
  def list_to_str(list)
    transform_to_string(list)
  end

  private

  #преобразование в хэш
  def transform_to_hashes(list_of_strings)
    list_of_hashes = []
    list_of_strings.each do |string|
      string = string.gsub('"', "")
      hash = {}
      string.split(',').each do |attribute|
        key, value = attribute.split(':').map(&:strip)
        hash[key.to_sym] = value
      end
      list_of_hashes << hash
    end
    list_of_hashes
  end

  #преобразвание в строку
  def transform_to_string(hashes)
    lines = hashes.map do |hash|
      hash.map { |key, value| "#{key}: #{value.inspect}" }.join(", ")
    end
    lines.join("\n")
  end
  
end