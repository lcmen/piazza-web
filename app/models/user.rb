class User < ApplicationRecord
  include Authenticable

  # Associations
  #----------------------------------------------------------------------------
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  # Validations
  #----------------------------------------------------------------------------
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  def email=(value)
    super(value.downcase.strip)
  end

  def name=(value)
    super(value.strip)
  end
end
