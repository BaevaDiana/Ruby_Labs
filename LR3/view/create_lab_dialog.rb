require 'fox16'

include Fox
class CreateLabDialog<FXDialogBox
  def initialize(parent, controller)
    super(parent, "Лабораторная работа", DECOR_TITLE | DECOR_BORDER | DECOR_RESIZE)
    @controller = controller
    @lab = nil
    setWidth(450)
    setHeight(290)
    add_fields
  end

  def set_lab(lab=nil)
    @lab=lab
    enter_lab
  end

  def add_fields
    frame_data = FXVerticalFrame.new(self, :opts=> LAYOUT_FILL_X|LAYOUT_FILL_Y )
    @field_text = {}

    field_name = [[:id, "Номер лабораторной"], [:name, 'Название'], [:date_start, 'Дата'],
                  [:themes, 'Темы'], [:tasks, 'Задачи']]
    field_name[0..2].each do |field|
      frame_field = FXHorizontalFrame.new(frame_data)
      field_label = FXLabel.new(frame_field, field[1], :opts => LAYOUT_FIX_WIDTH)
      field_label.setWidth(150)
      text = FXTextField.new(frame_field, 40, :opts=>TEXTFIELD_NORMAL)
      @field_text[field[0]] = text
    end

    field_name[3..4].each do |field|
      frame_field = FXHorizontalFrame.new(frame_data)
      field_label = FXLabel.new(frame_field, field[1], :opts => LAYOUT_FIX_WIDTH)
      field_label.setWidth(70)
      text = FXText.new(frame_field,:opts=> TEXT_AUTOSCROLL|LAYOUT_FIX_WIDTH)
      text.width= 330

      @field_text[field[0]] = text
    end



    @field_text[:id].editable = false
    btn_frame = FXHorizontalFrame.new(frame_data, LAYOUT_CENTER_X)
    btn_add=FXButton.new(btn_frame, "Сохранить")
    btn_add.textColor = Fox.FXRGB(0,23,175)
    btn_add.disable

    btn_back=FXButton.new(btn_frame, "Отмена")
    btn_back.textColor = Fox.FXRGB(0,23,175)

    btn_add.connect(SEL_COMMAND) do
      if @controller.validate_date_range(@lab.date_start, @lab.id)
        @controller.save_lab(@lab)
        self.handle(btn_add, FXSEL(Fox::SEL_COMMAND,
                                   Fox::FXDialogBox::ID_ACCEPT), nil)
      else
        puts "error"
      end

    end

    btn_back.connect(SEL_COMMAND) do
      self.handle(btn_back, FXSEL(Fox::SEL_COMMAND,
                                  Fox::FXDialogBox::ID_CANCEL), nil)
    end

    @field_text.each_key do |name_field|
      @field_text[name_field].connect(SEL_CHANGED) do |text_field|
        res = {}
        @field_text.each do |k,v|
          text = v.text.empty? ? nil : v.text
          res[k] = text
        end

        result = @controller.validate_fields(res)
        unless result.nil?
          @lab = result
          btn_add.enable
        else
          btn_add.disable
        end
      end
    end
  end

  def enter_lab
    unless @lab.nil?
      lab = @lab.to_hash
      @field_text.each_key do |name_field|
        @field_text[name_field].text = lab[name_field].to_s
      end
    else
      @field_text[:id].text = @controller.next_number_lab.to_s
    end

  end
end