class Organization < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :employees, dependent: :destroy
  
    before_validation :normalize_code
  
    validates :name, presence: true
    validates :code, presence: true, uniqueness: true, format: { with: /\A[A-Z0-9]+\z/, message: "must be uppercase alphanumeric" }
  
    private
  
    def normalize_code
      self.code = code.to_s.strip.upcase
    end
  end
