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
    Event.all.happening_this_month.count
  end 

  def title
    case action_name 
    when 'new', 'create', 'edit', 'update', 'show'
      "#{actions(action_name)} #{translated_resource_name}"
    when 'index' 
      translated_resource_name.pluralize
    else 
      t(action_name, scope: 'custom_actions')
    end 
  end 

  def devise_action
    t("#{controller_name}.#{action_name}", scope: 'controllers.devise')
  end

  def resource_name 
    controller_name.singularize
  end

  def translated_resource_name
    t(controller_name, scope: 'controllers').singularize
  end 

  def resource_path(action)
    case action 
    when 'new'
      eval("new_#{resource_name}_path")
    when 'edit'
      eval("edit_#{resource_name}_path(@#{(resource_name)})")
    when 'destroy', 'index'
      eval("#{resource_name}_path(@#{resource_name})")
    end
  end 

  def member_since(created_at)
    l(created_at, format: "%B de %Y")
  end 
end
