require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'Gera um número de série' do
    it 'ao criar um StockProduct' do
      # Arrange
      user = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')

      warehouse = Warehouse.create!(
        name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
        address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
      )
      supplier = Supplier.create!(
        corporate_name: 'Mobíliaria Attic LTDA', brand_name: 'Attic Mob', nif: '03126458670890',
        full_address: 'Centro Industrial de Macapá, 14', city: 'Macapá', state: 'AP',
        email: 'contato@shiqmob.com', contact_number: '+559631183804'
      )
      order = Order.create!(user:, warehouse:, supplier:, status: :delivered, estimated_delivery_date: 1.week.from_now)
     
      product = ProductModel.create!(
        supplier: supplier, name: 'Cadeira Desk',
        weight: 5, height: 100, width: 70, depth: 75,
        sku: 'CAD-DESK-10293874798'
      )
      # Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      # Assert
      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
      # Arrange
      user = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')

      warehouse1 = Warehouse.create!(
        name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
        address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
      )
      warehouse2 = Warehouse.create!(
        name: 'Guarulhos', code: 'GRU', city: 'São Paulo', area: 10_000, postal_code: '07190-100',
        address: 'Rod. Hélio Smidt, 1000', description: 'Galpão Internacional'
      )
      supplier = Supplier.create!(
        corporate_name: 'Mobíliaria Attic LTDA', brand_name: 'Attic Mob', nif: '03126458670890',
        full_address: 'Centro Industrial de Macapá, 14', city: 'Macapá', state: 'AP',
        email: 'contato@shiqmob.com', contact_number: '+559631183804'
      )

      order = Order.create!(user:, warehouse: warehouse1, supplier:, status: :delivered, estimated_delivery_date: 1.week.from_now)
      
      product = ProductModel.create!(
        supplier: supplier, name: 'Cadeira Desk',
        weight: 5, height: 100, width: 70, depth: 75,
        sku: 'CAD-DESK-10293874798'
      )
      stock_product = StockProduct.create!(order: order, warehouse: warehouse1, product_model: product)
      original_serial_number = stock_product.serial_number

      # Act
      stock_product.update(warehouse: warehouse2)

      # Assert
      expect(stock_product.serial_number).to eq original_serial_number
    end
  end

  describe '#available?' do
    it 'true se não tiver destino' do
      # Arrange
      user = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')

      warehouse = Warehouse.create!(
        name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
        address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
      )
      supplier = Supplier.create!(
        corporate_name: 'Mobíliaria Attic LTDA', brand_name: 'Attic Mob', nif: '03126458670890',
        full_address: 'Centro Industrial de Macapá, 14', city: 'Macapá', state: 'AP',
        email: 'contato@shiqmob.com', contact_number: '+559631183804'
      )
      order = Order.create!(user:, warehouse:, supplier:, status: :delivered, estimated_delivery_date: 1.week.from_now)
    
      product = ProductModel.create!(
        supplier: supplier, name: 'Cadeira Desk',
        weight: 5, height: 100, width: 70, depth: 75,
        sku: 'CAD-DESK-10293874798'
      )

      # Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      # Assert
      expect(stock_product.available?).to eq true

    end
    it 'false se tiver destino' do
       # Arrange
       user = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')

       warehouse = Warehouse.create!(
         name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
         address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
       )
       supplier = Supplier.create!(
         corporate_name: 'Mobíliaria Attic LTDA', brand_name: 'Attic Mob', nif: '03126458670890',
         full_address: 'Centro Industrial de Macapá, 14', city: 'Macapá', state: 'AP',
         email: 'contato@shiqmob.com', contact_number: '+559631183804'
       )
       order = Order.create!(user:, warehouse:, supplier:, status: :delivered, estimated_delivery_date: 1.week.from_now)
     
       product = ProductModel.create!(
         supplier: supplier, name: 'Cadeira Desk',
         weight: 5, height: 100, width: 70, depth: 75,
         sku: 'CAD-DESK-10293874798'
       )
 
       # Act
       stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
       stock_product.create_stock_product_destination(recipient: "Maria", address: "Rua da Maria")
 
       # Assert
       expect(stock_product.available?).to eq false
    end
  end
end
