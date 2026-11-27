class Country < ApplicationRecord
    has_many :employees
  
    before_validation :normalize_codes
  
    validates :name, presence: true
    validates :country_code, presence: true, uniqueness: true
    validates :currency_code, presence: true
  
    private
  
    def normalize_codes
      self.country_code = country_code.to_s.strip.upcase
      self.currency_code = currency_code.to_s.strip.upcase
    end
  end