class CreateCountries < ActiveRecord::Migration[8.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :country_code, null: false
      t.string :currency_symbol
      t.string :currency_code, null: false
      t.json :tax_configuration, null: false, default: {}

      t.timestamps
    end

    add_index :countries, :country_code, unique: true
  end
end