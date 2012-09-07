class AddEmployerFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_name, :string
    add_column :users, :phone, :string
  end
end
