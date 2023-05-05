require 'fox16'
include Fox

require_relative '/home/diana/LR3/controller/student_list_controller'

class Window<FXMainWindow

  def initialize(app)
    super(app, "Students" , :width => 1800, :height => 700)
    @students_on_page = 11
    @current_page = 1
    @count_student = 0
    @controller = StudentListController.new(self)
    create_tabs
  end
  def create_tabs
    tab_book = FXTabBook.new(self, :opts =>LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # создание первой вкладки
    tab1 = FXTabItem.new(tab_book, "Students_list_view", nil)
    composite1 = FXComposite.new(tab_book, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    @first_tab = FXHorizontalFrame.new(composite1)
    @first_tab.resize(1000,1000)
    first_tab

    # создание второй вкладки
    tab2 = FXTabItem.new(tab_book, "Вкладка 2", nil)
    @composite2 = FXComposite.new(tab_book, LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # создание третьей вкладки
    tab3 = FXTabItem.new(tab_book, "Вкладка 3", nil)
    @composite3 = FXComposite.new(tab_book, LAYOUT_FILL_X|LAYOUT_FILL_Y)
  end

  def create
    super
    show
    @controller.on_view_create
    @controller.refresh_data(@current_page, @students_on_page)
  end

  def update_count_students(count_students)
    @count_student = count_students
    #изменить отображение страниц

  end

  def on_datalist_changed(table)
    row_number=0
    table.each do |row|
      row_number+=1
      (1..3).each { |index_field| @table.setItemText(row_number, index_field-1, row[index_field])  }
    end
  end

  private

  def first_tab
    add_filters
    add_table
  end

  # создание области фильтрации
  def add_filters
    frame_filter = FXVerticalFrame.new(@first_tab)
    frame_filter.resize(500,300)

    field_filter =[[:git, 'Гит'], [:email, 'Почта'], [:phone, 'Телефон'], [:telegram, 'Телеграм']]

    # фильтр имени
    nameLabel = FXLabel.new(frame_filter, "Фамилия и инициалы")
    nameTextField = FXTextField.new(frame_filter, 40)
    @filter = {short_name: nameTextField}

    # фильтр для остальных полей
    field_filter.each do |field|
      @filter[field[0]] = create_radio_group(field, frame_filter)
    end

    #кнопка очистить
    btn_clear = FXButton.new(frame_filter, "Очистить", :opts=>BUTTON_NORMAL)
  end

  # создание таблицы
  def add_table
    table_frame = FXVerticalFrame.new(@first_tab, :padLeft=>20)

    # отображение страниц
    change_page = FXHorizontalFrame.new(table_frame, :opts=> LAYOUT_CENTER_X)

    # реализация кнопок смены страниц
    btn_back = FXButton.new(change_page, "Назад", :opts=> BUTTON_INITIAL)
    btn_back.textColor = Fox.FXRGB(0,23,175)
    # добавить отображение со страницы, на которой мы сейчас
    res = Array(1..@count_page).join(',')
    page_label = FXLabel.new(change_page, res)
    btn_next = FXButton.new(change_page, "Далее", :opts=> BUTTON_INITIAL)
    btn_next.textColor = Fox.FXRGB(0,23,175)

    # # создание таблицы
    # table = FXTable.new(table_frame, :opts =>  TABLE_READONLY|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT|TABLE_COL_SIZABLE|TABLE_ROW_RENUMBER, :width=>700, :height=>225)
    # table.setTableSize(11, 3)
    #
    # table.setColumnText(0, "ФИО")
    # table.setColumnText(1, "Git")
    # table.setColumnText(2, "Контакт")
    #
    # # заполнение таблицы примерами
    # table.setItemText(0, 0, "Baeva Diana")
    # table.setItemText(0, 1, "@pluxuryrockstar")
    # table.setItemText(0, 2, "BaevaDianawrk@gmail.com")
    #
    # table.setItemText(1, 0, "Boulevard Depo")
    # table.setItemText(1, 1, "@whereayo")
    # table.setItemText(1, 2, "pluxuty_sport@gmail.com")
    #
    # table.setItemText(2, 0, "SALUKI")
    # table.setItemText(2, 1, "@nesatyi.jr")
    # table.setItemText(2, 2, "saliki@gmail.com")
    #
    # table.setItemText(3, 0, "Devon Aoki")
    # table.setItemText(3, 1, "@suki")
    # table.setItemText(3, 2, "d.hunter@ewgtalent.com")
    #
    # table.setItemText(4, 0, "Mnogoznaal")
    # table.setItemText(4, 1, "@znaalmnogo")
    # table.setItemText(4, 2, "znaaet@gmail.com")
    #
    # table.setItemText(5, 0, "Georgy Visnu")
    # table.setItemText(5, 1, "@visnuvision")
    # table.setItemText(5, 2, "paytovisnu@gmail.com")
    #
    # table.setItemText(6, 0, "Payton")
    # table.setItemText(6, 1, "@pay")
    # table.setItemText(6, 2, "payton@gmail.com")
    #
    # table.setItemText(7, 0, "White Punk")
    # table.setItemText(7, 1, "@whitepunklive")
    # table.setItemText(7, 2, "dennyxdvrko@gmail.com")
    #
    # table.setItemText(8, 0, "Karina Istomina")
    # table.setItemText(8, 1, "@diamond_april")
    # table.setItemText(8, 2, "KarinaIstomina94@gmail.com")
    #
    # table.setItemText(9, 0, "Vinnie Hacker")
    # table.setItemText(9, 1, "@vinnie")
    # table.setItemText(9, 2, "vinniehacker@gmail.com")
    #
    # table.setItemText(10, 0, "Dirty Morty")
    # table.setItemText(10, 1, "@lilmorty")
    # table.setItemText(10, 2, "dirtymortybooking@gmail.com")
    @table = FXTable.new(table_frame, :opts =>  TABLE_READONLY|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT|TABLE_COL_SIZABLE|TABLE_ROW_RENUMBER, :width=>580, :height=>320)
    @table.setTableSize(10, 3)

    @table.setColumnText(0, "ФИО")
    @table.setColumnText(1, "Git")
    @table.setColumnText(2, "Контакт")

    # масштабирование таблицы
    @table.setRowHeaderWidth(30)
    @table.setColumnWidth(0, 115)
    @table.setColumnWidth(1, 115)
    @table.setColumnWidth(2, 195)

    # создание кнопок
    btn_list = FXHorizontalFrame.new(table_frame)
    btn_add = FXButton.new(btn_list, "Добавить", :opts=>BUTTON_NORMAL)
    btn_update = FXButton.new(btn_list, "Обновить", :opts=>BUTTON_NORMAL)
    btn_change = FXButton.new(btn_list, "Изменить", :opts=>BUTTON_NORMAL)
    btn_delete = FXButton.new(btn_list, "Удалить", :opts=>BUTTON_NORMAL)

    btn_change.disable
    btn_delete.disable

    # установка обработчика события SEL_CHANGED для таблицы
    @table.connect(SEL_CHANGED) do
      num_selected_rows = 0
      (0...@table.getNumRows()).each { |row_index| num_selected_rows+=1 if @table.rowSelected?(row_index)}
      # если выделена только одна строка, кнопка должна быть неактивной
      if num_selected_rows == 1
        btn_change.enable
        btn_delete.enable
        # если выделено несколько строк, кнопка должна быть активной
      elsif num_selected_rows > 1
        btn_change.disable
        btn_delete.enable
      end
    end

    # связывание события нажатия на заголовок столбца таблицы и его сортировки
    @table.getColumnHeader.connect(SEL_COMMAND) do |a, b, col|
      sort_table_by_column(@table, col)
    end

    #  связывание события нажатия кнопкой мыши на строку таблицы с методом, который удаляет выделение в таблице, и методами, которые отключают кнопки
    @table.getRowHeader.connect(SEL_RIGHTBUTTONPRESS) do
      @table.killSelection(true)
      btn_change.disable
      btn_delete.disable
    end

  end

  # сортировка таблицы по столбцу
  def sort_table_by_column(table, column_index)
    table_data = (0...table.getNumRows()).map { |row_index| (0...table.getNumColumns()).map { |col_index| table.getItemText(row_index, col_index) } }
    sorted_table_data = table_data.sort_by { |row_data| row_data[column_index] }
    sorted_table_data.each_with_index do |row_data, row_index|
      row_data.each_with_index do |cell_data, col_index|
        table.setItemText(row_index, col_index, cell_data)
      end
    end
  end

  # создание радиокнопок
  def create_radio_group(field, parent)

    frame_field = FXVerticalFrame.new(parent, LAYOUT_FILL_X||LAYOUT_SIDE_TOP)
    label_field = FXLabel.new(frame_field, field[1])

    line_radio = FXHorizontalFrame.new(frame_field, LAYOUT_FILL_X|LAYOUT_SIDE_TOP)

    radio_yes = FXRadioButton.new(line_radio, "Да")
    radio_no = FXRadioButton.new(line_radio, "Нет")
    radio_no_matter = FXRadioButton.new(line_radio, "Не важно")

    # фильтр
    text_field = FXTextField.new(line_radio, 40)

    # обеспечение доступности
    text_field.setEnabled(false)
    radio_yes.connect(SEL_COMMAND) do
      radio_no.check=false
      radio_no_matter.check=false
      if radio_yes.checked?
        text_field.setEnabled(true)
      end
    end

    radio_no.connect(SEL_COMMAND) do
      radio_no_matter.check=false
      radio_yes.check=false
      if radio_no.checked?
        text_field.setEnabled(false)
      end
    end

    radio_no_matter.connect(SEL_COMMAND) do
      radio_no.check=false
      radio_yes.check=false
      if radio_no_matter.checked?
        text_field.setEnabled(false)
      end
    end

    frame_field
  end

end


