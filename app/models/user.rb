class User < ApplicationRecord
  has_secure_password
  belongs_to :organization
  has_many :sessions, dependent: :destroy

  enum :role, {
    hr_admin: "hr_admin",
    hr_manager: "hr_manager",
    employee: "employee"
  }, default: "employee"

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :role, presence: true
  validates :email_address,
    uniqueness: { scope: :organization_id }
end
