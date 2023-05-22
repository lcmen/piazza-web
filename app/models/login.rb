class Login < ApplicationRecord
  belongs_to :user, inverse_of: :logins

  before_create :generate_token

  has_secure_password :token, validations: false

  def to_h
    { id:, user_id:, token: }
  end

  private

  def generate_token
    self.token = self.class.generate_unique_secure_token
  end
end
