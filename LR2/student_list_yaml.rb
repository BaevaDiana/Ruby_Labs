require_relative 'student_list_base'
require 'yaml'

class StudentListYAML < StudentListBase
  public_class_method :new

  protected

  def str_to_list(str)
    YAML.safe_load(str).map{ |h| h.transform_keys(&:to_sym)}
  end

  def list_to_str(list)
    YAML.dump(list.map{ |h| h.transform_keys(&:to_s)})
  end
end

