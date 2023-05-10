class User < ApplicationRecord
  # Attributes
  #----------------------------------------------------------------------------
  has_secure_password

  # Associations
  #----------------------------------------------------------------------------
  has_many :logins, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  # Validations
  #----------------------------------------------------------------------------
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 8 }, presence: true
  validates :password_confirmation, presence: true

  def self.authenticate(id:, login_id:, token:)
    user = User.find(id)
    user.logins.find(login_id).authenticate_token(token)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def self.login(email:, password:)
    user = User.find_by(email: email)&.authenticate(password)
    return if user.blank?

    user.logins.create
  end

  def email=(value)
    super(value.downcase.strip)
  end

  def name=(value)
    super(value.strip)
  end
end
