require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      # Arrange
      user = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')
      warehouse = Warehouse.create!(
        name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
        address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
      )
      supplier = Supplier.create!(
        corporate_name: 'Instituto X de Fornecimento', brand_name: 'Fornecedor X', nif: '03126458670890',
        full_address: 'Rua Juventino da Silva, 14', city: 'Ipiaú', state: 'BA',
        email: 'contato@xmen.com', contact_number: '+557331183804'
      )
      order = Order.new(user:, warehouse:, supplier:, estimated_delivery_date: '2022-10-01')
      # Act
      result = order.valid?
      # Assert
      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      # Arrange
      order = Order.new(estimated_delivery_date: '')
      order.valid?
      # Act
      result = order.errors.include? :estimated_delivery_date
      # Assert
      expect(result).to be true
    end

    it 'data estimada de entrega não pode ser retroativa' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)
      # Act
      order.valid?
      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data estimada de entrega não deve ser igual a hoje' do
      # Arrange
      order = Order.new(estimated_delivery_date: Date.today)
      # Act
      order.valid?
      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data estimada de entrega deve ser igual ou maior do que amanhã' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      # Act
      order.valid?
      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be false
    end
  end

  describe 'Gera um código aleatório' do
    it 'ao criar um novo pedido' do
      # Arrange
      user = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')
      warehouse = Warehouse.create!(
        name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
        address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
      )
      supplier = Supplier.create!(
        corporate_name: 'Instituto X de Fornecimento', brand_name: 'Fornecedor X', nif: '03126458670890',
        full_address: 'Rua Juventino da Silva, 14', city: 'Ipiaú', state: 'BA',
        email: 'contato@xmen.com', contact_number: '+557331183804'
      )
      order = Order.new(user:, warehouse:, supplier:, estimated_delivery_date: '2022-10-01')
      # Act
      order.save!
      result = order.code
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'e o código é unico' do
      # Arrange
      user = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')
      warehouse = Warehouse.create!(
        name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
        address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
      )
      supplier = Supplier.create!(
        corporate_name: 'Instituto X de Fornecimento', brand_name: 'Fornecedor X', nif: '03126458670890',
        full_address: 'Rua Juventino da Silva, 14', city: 'Ipiaú', state: 'BA',
        email: 'contato@xmen.com', contact_number: '+557331183804'
      )
      first_order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: '2022-10-01')
      second_order = Order.new(user:, warehouse:, supplier:, estimated_delivery_date: '2022-11-15')
      # Act
      second_order.save!
      result = second_order.code
      # Assert
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
