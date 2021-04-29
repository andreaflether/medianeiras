# frozen_string_literal: true

module ApplicationHelper
  def toastr_classes_for(flash_type)
    type = {
      success: 'success',
      error: 'error',
      alert: 'warning',
      notice: 'info'
    }

    type[flash_type.to_sym]
  end

  def custom_flash_messages
    if flash.to_h.any?
      script = '<script>'
      flash.each do |type, message|
        script += "toastr['#{toastr_classes_for(type)}'](\"#{message}\")"
      end
      script += '</script>'
      # flash.clear
      flash.to_h.any? ? script.html_safe : ''
    end
  end

  def date_format(date, format)
    date.nil? ? '' : l(date, format: format.to_sym)
  end

  def time_format(time, format)
    time.nil? ? '' : l(time, format: format.to_sym)
  end
end
