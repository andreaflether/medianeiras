# frozen_string_literal: true

crumb :events do
  link 'Eventos', admin_events_path
end

crumb :event do |event|
  link event.title.truncate(50), admin_event_path(event)
  parent :events
end

crumb :new_event do
  link 'Cadastrar', new_admin_event_path
  parent :events
end

crumb :edit_event do
  link 'Editar', edit_admin_event_path
  parent :events
end

crumb :calendar do
  link 'Calendário', calendar_admin_events_path
  parent :events
end
