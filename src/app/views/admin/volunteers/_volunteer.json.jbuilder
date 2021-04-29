# frozen_string_literal: true

json.extract! volunteer, :id, :email, :speciality, :cpf, :created_at, :updated_at
json.url volunteer_url(volunteer, format: :json)
