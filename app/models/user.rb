# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[user admin superadmin]

  # Validations
  validates :full_name, presence: true, length: { minimum: 3, allow_blank: true }

  def admin?
    !user?
  end
end
