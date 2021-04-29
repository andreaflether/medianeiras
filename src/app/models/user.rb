# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[usuario admin superadmin]

  # Validations
  validates :full_name, presence: true, length: { minimum: 3, allow_blank: true }

  def admin?
    !usuario?
  end
end
