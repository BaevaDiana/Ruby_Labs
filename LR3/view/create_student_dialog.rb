require 'fox16'
include Fox

class CreateStudentDialog<FXDialogBox
  def initialize(parent, controller)
    # создание родительского модального окна
    super(parent, "Добавление студента", DECOR_TITLE | DECOR_BORDER | DECOR_RESIZE)

    @controller = controller

    # установка размера окна и его модальности
    setWidth(500)
    setHeight(300)
    add_fields
    # setModal(true)
  end

  def add_fields
    #к нопка отмены

    frame_data = FXVerticalFrame.new(self, :opts=> LAYOUT_FILL_X|LAYOUT_FILL_Y )

    field_name =[[:last_name,'Фамилия'], [:first_name, 'Имя'], [:surname, 'Отчество'], [:git, 'Гит'], [:email, 'Почта'], [:phone, 'Телефон'], [:telegram, 'Телеграм']]
    @field_text = {}
    field_name.each do |field|
      frame_field = FXHorizontalFrame.new(frame_data )
      field_label = FXLabel.new(frame_field, field[1], :opts => LAYOUT_FIX_WIDTH)
      field_label.setWidth(100)
      text = FXTextField.new(frame_field, 40, :opts=>TEXTFIELD_NORMAL)
      @field_text[field[0]] = text
    end

    btn_add = FXButton.new(frame_data, "Добавить")
    btn_add.textColor = Fox.FXRGB(0,23,175)
    btn_add.disable

    @field_text.each_key do |name_field|
      @field_text[name_field].connect(SEL_CHANGED) do |text_field|
        res = []
        @field_text.each do |k,v|
          text = v.text.empty? ? nil : v.text
          res<<[k,text]
        end
        res = res.to_h

        result = @controller.validate_fields(res)
        if result.class==Student
          btn_add.enable
        else
          btn_add.disable
        end

      end
    end


  end
end



