class ChangeCepToPostalCodeOnWarehouses < ActiveRecord::Migration[7.0]
  def change
    rename_column :warehouses, :cep, :postal_code
  end
end
