class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :string, null: false, default: "employee"

    add_column :users, :name, :string

    add_reference :users, :organization,
      null: false,
      foreign_key: true

    remove_index :users, :email_address

    add_index :users,
      [:organization_id, :email_address],
      unique: true
  end
end
