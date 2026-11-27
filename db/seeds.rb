# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Add countries to the database
countries = [
  {
    name: "India",
    country_code: "IN",
    currency_symbol: "₹",
    currency_code: "INR",
    tax_configuration: {
        "tax_regimes": {
          "old_regime": {
            "financial_year": "2026-27",
            "standard_deduction": 50000,
            "tax_slabs": [
              { "min": 0, "max": 250000, "rate": 0 },
              { "min": 250000, "max": 500000, "rate": 5 },
              { "min": 500000, "max": 1000000, "rate": 20 },
              { "min": 1000000, "max": nil, "rate": 30 }
            ]
          },
          "new_regime": {
            "financial_year": "2026-27",
            "standard_deduction": 75000,
            "tax_slabs": [
              { "min": 0, "max": 400000, "rate": 0 },
              { "min": 400000, "max": 800000, "rate": 5 },
              { "min": 800000, "max": 1200000, "rate": 10 },
              { "min": 1200000, "max": 1600000, "rate": 15 },
              { "min": 1600000, "max": 2000000, "rate": 20 },
              { "min": 2000000, "max": 2400000, "rate": 25 },
              { "min": 2400000, "max": nil, "rate": 30 }
            ]
          }
        }
      }
  },
  {
    name: "United States",
    country_code: "US",
    currency_symbol: "$",
    currency_code: "USD",
    tax_configuration: {
      tax_type: "progressive",
      tax_year: "2026"
    }
  },
  {
    name: "United Kingdom",
    country_code: "GB",
    currency_symbol: "£",
    currency_code: "GBP",
    tax_configuration: {
      tax_type: "progressive",
      tax_year: "2026"
    }
  }
]

# Add organizations to the database
organizations = [
  {
    name: "ACME Corporation",
    code: "ACME",
    users: [
      {
        name: "Administrator 1",
        email_address: "admin@acme.com",
        password: "Password@123",
        role: :hr_admin
      },
      {
        name: "Manager 1",
        email_address: "manager@acme.com",
        password: "Password@123",
        role: :hr_manager
      }
    ]
  },
  {
    name: "TechCorp",
    code: "TECHCORP",
    users: [
      {
        name: "Administrator 2",
        email_address: "admin@techcorp.com",
        password: "Password@123",
        role: :hr_admin
      },
      {
        name: "Manager 2",
        email_address: "manager@techcorp.com",
        password: "Password@123",
        role: :hr_manager
      }
    ]
  }
]

countries.each do |attributes|
  country = Country.find_or_initialize_by(
    country_code: attributes[:country_code]
  )

  country.update!(attributes)
end

organizations.each do |organization_data|
  organization = Organization.find_or_create_by!(
    code: organization_data[:code]
  ) do |org|
    org.name = organization_data[:name]
  end

  organization_data[:users].each do |user_data|
    organization.users.find_or_initialize_by(
      email_address: user_data[:email_address],
      organization_id: organization.id
    ).update!(
      password: user_data[:password],
      role: user_data[:role]
    )
  end
end

