module AdminHelper
  def actions(action)
    case action
    when 'new', 'create'
      'Cadastrar'
    when 'edit', 'update'
      'Editar'
    when 'show'
      'Visualizar'
    when ''
      'Formulário'
    end  
  end 
  
  def events_count 
    Event.all.this_month.count
  end 

  def title(action_name, controller_name)
    case action_name 
    when 'new', 'create', 'edit', 'update', 'show'
      actions(action_name) + " " + t(controller_name, scope: 'controllers').singularize
    when 'index' 
      t(controller_name, scope: 'controllers')
    else 
      t(action_name, scope: 'custom_actions')
    end 
  end 

  def devise_action(action, controller)
    case action
    when 'new'
      case controller
      when 'passwords'
        'Recuperar senha'
      when 'registrations'
        'Criar conta'
      when 'sessions'
        'Entrar'
      end
    when 'edit'
      case controller
      when 'registrations'
        'Editar informações de conta'
      when 'passwords'
        'Alterar senha'
      end
    when 'create'
      case controller
      when 'registrations'
        'Criar Conta'
      end
    end
  end

  def path(controller)
    resource = controller.singularize
    eval("#{resource}_path(@#{resource})")
  end 

  def resource_name(resource)
    t(resource, scope: 'controllers').singularize
  end 

  def member_since(created_at)
    l(created_at, format: "%B de %Y")
  end 
end
