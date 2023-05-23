
require 'fox16'
include Fox
require_relative '/home/diana/LR3/labs_controller/student_lab_controller'
require_relative '/home/diana/LR3/view/student_tab'

class TabLab<FXVerticalFrame
  def initialize(parent, *args, &blk)
    super
    @controller = StudentLabController.new(self)
    add_table
  end

  def add_table
    table_frame = FXVerticalFrame.new(self, :padLeft=>20)
    # page_change_buttons(table_frame)
    # Создаем таблицу
    @table = FXTable.new(table_frame, :opts =>  TABLE_READONLY|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT|TABLE_COL_SIZABLE|TABLE_ROW_RENUMBER, :width=>800, :height=>400)
    @table.setTableSize(16, 3)

    @table.setColumnText(0, "Номер")
    @table.setColumnText(1, "Наименование")
    @table.setColumnText(2, "Дата выдачи")

    # Масштабируем таблицу
    @table.setRowHeaderWidth(30)
    @table.setColumnWidth(1, 400)
    @table.setColumnWidth(2, 250)

    @table.getColumnHeader.connect(SEL_COMMAND) do |a, b, col|
      sort_table_by_column(@table, col)
    end

    btn_list = FXHorizontalFrame.new(table_frame, :opts => LAYOUT_CENTER_X)
    # Создаем кнопку "Добавить"
    btn_add = FXButton.new(btn_list, "Добавить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_add.backColor = FXRGB(255, 255, 255)
    btn_add.textColor = FXRGB(0, 0, 0)
    btn_add.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    # Создаем кнопку "Удалить"
    btn_delete = FXButton.new(btn_list, "Удалить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_delete.backColor = FXRGB(255, 255, 255)
    btn_delete.textColor = FXRGB(0, 0, 0)
    btn_delete.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    # Создаем кнопку "Обновить"
    btn_refresh = FXButton.new(btn_list, "Обновить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_refresh.backColor = FXRGB(255, 255, 255)
    btn_refresh.textColor = FXRGB(0, 0, 0)
    btn_refresh.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    # Создаем кнопку "Изменить"
    btn_remove = FXButton.new(btn_list, "Изменить", :opts => BUTTON_NORMAL | LAYOUT_CENTER_Y)
    btn_remove.backColor = FXRGB(255, 255, 255)
    btn_remove.textColor = FXRGB(0, 0, 0)
    btn_remove.font = FXFont.new(app, "Arial", 10, :weight => FONTWEIGHT_BOLD)


    btn_delete.disable
    btn_remove.disable

    @table.connect(SEL_CHANGED) do
      num_selected_rows = 0
      (0...@table.getNumRows()).each { |row_index| num_selected_rows+=1 if @table.rowSelected?(row_index)}

      # Если выделена только одна строка, кнопка должна быть неактивной
      if num_selected_rows >= 1
        btn_remove.enable
        if @table.rowSelected?(@controller.get_count_lab-1) and num_selected_rows ==1
          btn_delete.enable
        end
        # Если выделено несколько строк, кнопка должна быть активной
      elsif num_selected_rows >1
        btn_delete.disable
      end
    end

    @table.getRowHeader.connect(SEL_RIGHTBUTTONPRESS) do
      @table.killSelection(true)
      btn_remove.disable
      btn_delete.disable
    end

    btn_refresh.connect(SEL_COMMAND) do
      refresh
    end

    btn_add.connect(SEL_COMMAND) do
      @controller.add_lab
    end

    btn_delete.connect(SEL_COMMAND) do
      @controller.delete_lab
      @table.killSelection
    end

    btn_remove.connect(SEL_COMMAND) do
      index = (0...@table.getNumRows).find {|row_index| @table.rowSelected?(row_index)}
      @controller.update_lab(index)
    end

  end

  def refresh
    @controller.refresh_data
  end


  def on_datalist_changed(table)
    TabStudent.update_data_table(@table, table)
  end

  def sort_table_by_column(table, column_index)
    table_data = []
    (0...table.getNumRows()).each do |row_index|
      if table.getItemText(row_index, column_index)!=''
        row=[]
        (0...table.getNumColumns()).each do |col_index|
          row[col_index] = table.getItemText(row_index, col_index)
        end
        table_data<<row
      end
    end
    sorted_table_data = table_data.sort_by { |row_data| row_data[column_index] }
    sorted_table_data.each_with_index do |row_data, row_index|
      row_data.each_with_index do |cell_data, col_index|
        table.setItemText(row_index, col_index, cell_data)
      end
    end
  end

end
