class DataTable

  attr_reader :rows_count, :cols_count

  # конструктор 
  def initialize(table)
    self.rows_count = table.length
    max_cols = 0
    table.each do |row|
      max_cols = row.length if row.size > max_cols
    end
    self.cols_count = max_cols
    self.table = table
  end

  # метод, воз-ий элемент по номеру строки и столбца
  def get_elements(row, col)
    return nil if row >= rows_count || row.negative?
    return nil if col >= cols_count || col.negative?

    table[row][col]
  end

  def to_s
    table.map { |row| "[#{row.join(', ')}]" }.join("\n")
  end

  def each(&block)
    table.each do |row|
      block.call(row)
    end
  end

  private

  attr_accessor :table
  attr_writer :rows_count, :cols_count

end