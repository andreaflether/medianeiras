# frozen_string_literal: true

crumb :activities do
  link 'Atividades', admin_activities_path
end

crumb :activity do |activity|
  link activity.name.truncate(50), admin_activity_path(activity)
  parent :activities
end

crumb :new_activity do
  link 'Cadastrar', new_admin_activity_path
  parent :activities
end

crumb :edit_activity do
  link 'Editar', edit_admin_activity_path
  parent :activities
end
