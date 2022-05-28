require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    # Arrange
    manoel = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'Fábrica de Tênis LTDA', brand_name: 'Get Shoes', nif: '97456789012560',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )
    order = Order.create!(user: manoel, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)

    # Act
    visit edit_order_path(order.id)

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    # Arrange
    manoel = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'Fábrica de Tênis LTDA', brand_name: 'Get Shoes', nif: '97456789012560',
      full_address: 'Avenida Angélica, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )
    second_supplier = Supplier.create!(
      corporate_name: 'Fábrica de Camisas LTDA', brand_name: 'Get Shirts', nif: '36374895029284',
      full_address: 'Ali na esquina, 14', city: 'Salvador', state: 'BA',
      email: 'contato@getshirts.com', contact_number: '+5571322334455'
    )
    order = Order.create!(user: manoel, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(manoel, scope: :user)
    visit root_path
    click_on('Meus Pedidos')
    click_on(order.code)
    click_on('Editar')
    fill_in 'Data Prevista de Entrega', with: '12/12/2022'
    select 'Fábrica de Camisas LTDA', from: 'Fornecedor'
    click_on('Gravar')

    # Assert
    expect(page).to have_content('Pedido atualizado com sucesso.')
    expect(page).to have_content('Fornecedor: Fábrica de Camisas LTDA')
    expect(page).to have_content('Data Prevista de Entrega: 12/12/2022')
  end

  it 'caso seja o responsável' do
    # Arrange
    andre = User.create!(name: 'Andre', email: 'andre@email.com', password: '123456')
    manoel = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'Fábrica de Tênis LTDA', brand_name: 'Get Shoes', nif: '97456789012560',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )
    order = Order.create!(user: manoel, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(andre)
    visit edit_order_path(order.id)

    # Assert
    expect(current_path).to eq root_path
  end
end
