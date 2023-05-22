module Authenticable
  extend ActiveSupport::Concern

  included do
    has_many :logins, dependent: :destroy
    has_secure_password

    validates :password, length: { minimum: 8 }, presence: true
    validates :password_confirmation, presence: true
  end

  class_methods do
    def authenticate(id:, login_id:, token:)
      user = User.find(id)
      user.logins.find(login_id).authenticate_token(token)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def login(email:, password:)
      user = User.find_by(email: email)&.authenticate(password)
      return if user.blank?

      user.logins.create
    end
  end
end
