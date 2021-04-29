# frozen_string_literal: true

json.extract! suggestion, :id, :parents, :children, :comments, :created_at, :updated_at
json.url suggestion_url(suggestion, format: :json)
