# frozen_string_literal: true

json.extract! event, :id, :title, :description, :start_date, :end_date, :location, :created_at, :updated_at
json.url event_url(event, format: :json)
