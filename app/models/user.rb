class User < ApplicationRecord
  # Attributes
  #----------------------------------------------------------------------------
  has_secure_password

  # Associations
  #----------------------------------------------------------------------------
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  # Validations
  #----------------------------------------------------------------------------
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 8 }, presence: true
  validates :password_confirmation, presence: true

  def email=(value)
    super(value.downcase.strip)
  end

  def name=(value)
    super(value.strip)
  end
end
