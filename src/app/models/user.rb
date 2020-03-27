class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [ :usuario, :admin, :superadmin ]

  # Validations 
  validates :first_name, presence: true, length: {minimum: 3}, on: :update, unless: :reset_password_token_present?

  # Virtual Attributes
  def full_name 
    [self.first_name, self.last_name].join(' ')
  end 

  def admin?
    ! usuario?
  end

  private 

  def reset_password_token_present?
    !!$global_params[:user][:password_token]
  end 
end
