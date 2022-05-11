class AddAttributesToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :postal_code, :string
    add_column :warehouses, :description, :string
  end
end
