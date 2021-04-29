# frozen_string_literal: true

class TempusDominusInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    template.content_tag(:div, class: 'input-group date', data: { target_input: 'nearest' }, id: "#{object_name}_#{attribute_name}") do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat div_button
    end
  end

  def input_html_options
    super.merge({ class: 'form-control datetimepicker-input' })
  end

  def div_button
    template.content_tag(:div, class: 'input-group-append', data: { target: "##{object_name}_#{attribute_name}", toggle: 'datetimepicker' }) do
      template.concat span_table
    end
  end

  def span_table
    template.content_tag(:div, class: 'input-group-text') do
      template.concat icon_table
    end
  end

  def icon_remove
    "<i class='glyphicon glyphicon-remove'></i>".html_safe
  end

  def icon_table
    "<i class='fa fa-clock'></i>".html_safe
  end
end
