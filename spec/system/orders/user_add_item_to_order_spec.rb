require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')

    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )

    supplier = Supplier.create!(
      corporate_name: 'Fábrica de Tênis LTDA', brand_name: 'Get Shoes', nif: '97456789012560',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)

    product_a = ProductModel.create!(
      name: 'Produto A', weight: 1, width: 10, height: 15,
      depth: 10, supplier:, sku: 'sku-a123456789123456'
    )
    product_b = ProductModel.create!(
      name: 'Produto B', weight: 1, width: 10, height: 15,
      depth: 10, supplier:, sku: 'sku-b123456789123456'
    )

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: 8
    click_on 'Adicionar'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it 'e não vê produtos de outro fornecedor' do
    # Arrange
    user = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')

    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )

    supplier_a = Supplier.create!(
      corporate_name: 'Fábrica de Tênis LTDA', brand_name: 'Get Shoes', nif: '97456789012560',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )

    supplier_b = Supplier.create!(
      corporate_name: 'Fábrica de Camisa LTDA', brand_name: 'Get Shirts', nif: '10456789012560',
      full_address: 'Rua das Vestes, 14', city: 'Jaguaquara', state: 'BA',
      email: 'contato@getshirts.com', contact_number: '+557533224455'
    )

    order = Order.create!(user:, warehouse:, supplier: supplier_a, estimated_delivery_date: 1.day.from_now)

    product_a = ProductModel.create!(
      name: 'Produto A', weight: 1, width: 10, height: 15,
      depth: 10, supplier: supplier_a, sku: 'sku-a123456789123456'
    )

    product_b = ProductModel.create!(
      name: 'Produto B', weight: 1, width: 10, height: 15,
      depth: 10, supplier: supplier_b, sku: 'sku-b123456789123456'
    )

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    # Assert
    expect(page).to have_content 'Produto A'
    expect(page).to_not have_content 'Produto B'
    
  end
end