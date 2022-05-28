require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    # Arrange
    # Act
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    manoel = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password: '123456')
    warehouse1 = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )
    warehouse2 = Warehouse.create!(
      name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', area: 100_000, postal_code: '25000-000',
      address: 'Avenida do Porto, 80', description: 'Galpão destinado a cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'Fábrica de Tênis LTDA', brand_name: 'Get Shoes', nif: '97456789012560',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )
    order1 = Order.create!(user: manoel, warehouse: warehouse1, supplier:, estimated_delivery_date: 1.day.from_now,
                           status: 'pending')
    order2 = Order.create!(user: carla, warehouse: warehouse1, supplier:, estimated_delivery_date: 1.day.from_now,
                           status: 'delivered')
    order3 = Order.create!(user: manoel, warehouse: warehouse2, supplier:, estimated_delivery_date: 1.day.from_now,
                           status: 'canceled')

    # Act
    login_as(manoel, scope: :user)
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(page).to have_content(order1.code)
    expect(page).to have_content('Pendente')
    expect(page).not_to have_content(order2.code)
    expect(page).not_to have_content('Entregue')
    expect(page).to have_content(order3.code)
    expect(page).to have_content('Cancelado')
  end

  it 'e visita um pedido' do
    manoel = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password: '123456')
    warehouse1 = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )
    warehouse2 = Warehouse.create!(
      name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', area: 100_000, postal_code: '25000-000',
      address: 'Avenida do Porto, 80', description: 'Galpão destinado a cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'Fábrica de Tênis LTDA', brand_name: 'Get Shoes', nif: '97456789012560',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )
    order1 = Order.create!(user: manoel, warehouse: warehouse1, supplier:, estimated_delivery_date: 1.day.from_now)
    order2 = Order.create!(user: carla, warehouse: warehouse1, supplier:, estimated_delivery_date: 1.day.from_now)
    order3 = Order.create!(user: manoel, warehouse: warehouse2, supplier:, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(manoel, scope: :user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order1.code

    # Assert
    expect(page).to have_content('Detalhes do Pedido')
    expect(page).to have_content(order1.code)
    expect(page).to have_content('Galpão Destino: GRU - Aeroporto SP')
    expect(page).to have_content('Fornecedor: Fábrica de Tênis LTDA')
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content("Data Prevista de Entrega: #{formatted_date}")
  end

  it 'e não pode visitar um pedido de outro usuário' do
    manoel = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')
    andre = User.create!(name: 'Andre', email: 'andre@email.com', password: '123456')
    warehouse1 = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )
    warehouse2 = Warehouse.create!(
      name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', area: 100_000, postal_code: '25000-000',
      address: 'Avenida do Porto, 80', description: 'Galpão destinado a cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'Fábrica de Tênis LTDA', brand_name: 'Get Shoes', nif: '97456789012560',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )
    order = Order.create!(user: manoel, warehouse: warehouse1, supplier:, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(andre, scope: :user)
    visit order_path(order.id)

    # Assert
    expect(current_path).not_to eq order_path(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content('Você não tem permissão para acessar esse pedido')
  end
end
