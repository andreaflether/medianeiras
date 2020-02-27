module ApplicationHelper
  def devise_action(action, controller)
    case action
    when "new"
      case controller
      when "passwords"
        "Recuperar senha"
      when "registrations"
        "Criar conta"
      when "sessions"
        "Entrar"
      end
    when "edit"
      case controller
      when "registrations"
        "Editar informações de conta"
      when "passwords"
        "Mudar senha"
      end
    end
  end

  def custom_flash_messages
    flash_messages = []
    flash.each do |type, message| # Overall flash messages
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>$( document ).ready(function() {toastr.#{type}('#{message}');});</script>"
      flash_messages << text.html_safe if message
    end
    resource.errors.full_messages.each do |m| # Devise messages
      text = "<script>$(document).ready(function() {
      toastr.error('#{m}');
      });</script>"
      flash_messages << text.html_safe if m
    end
    flash_messages.join("\n").html_safe
  end
end # End module
