# frozen_string_literal: true

json.extract! activity, :id, :name, :description, :location, :days, :time_schedule, :max_capacity, :created_at, :updated_at
json.url activity_url(activity, format: :json)
