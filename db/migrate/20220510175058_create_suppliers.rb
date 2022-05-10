class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :nif
      t.string :full_address
      t.string :city
      t.string :state
      t.string :email
      t.string :contact_number

      t.timestamps
    end
  end
end
