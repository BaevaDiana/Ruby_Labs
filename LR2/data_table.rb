class DataTable

	def initialize(table)
		@table = table
	end

	# метод, возв-ий элемент по номеру строки и столбца
	def get_element(row, col)
		@table[row][col]
	end

    # метод, возв-ий кол-во строк
	def row_count
		@table.size
	end

	# метод, возв-ий кол-во столбцов
	def column_count
		@table[0].size
	end
end

table1 = DataTable.new([
                        10, 20, 40,
                        10, 20, 30,
                        40, 50, 60
                      ])

puts table1.get_element(3, 3) 