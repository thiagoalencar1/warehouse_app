require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    # Arrange
    thiago = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')
    Warehouse.create!(
      name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
      address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
    )
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'Indústria Textil LTDA', brand_name: 'Vestil', nif: '03126458670890',
      full_address: 'Centro Industrial de Macapá, 14', city: 'Macapá', state: 'AP',
      email: 'contato@vestil.com', contact_number: '+559631183804'
    )
    order = Order.create!(user: thiago, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now,
                          status: :pending)

    # Act
    login_as(thiago, scope: :user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Entregue'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Situação do Pedido: Entregue')
    expect(page).not_to have_button('Marcar como Entregue')
    expect(page).not_to have_button('Marcar como Cancelado')
  end

  it 'e pedido foi cancelado' do
    # Arrange
    thiago = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')
    Warehouse.create!(
      name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
      address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
    )
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'Indústria Textil LTDA', brand_name: 'Vestil', nif: '03126458670890',
      full_address: 'Centro Industrial de Macapá, 14', city: 'Macapá', state: 'AP',
      email: 'contato@vestil.com', contact_number: '+559631183804'
    )
    order = Order.create!(user: thiago, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now,
                          status: :pending)

    # Act
    login_as(thiago, scope: :user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Cancelado'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Situação do Pedido: Cancelado')
    expect(page).not_to have_button('Marcar como Entregue')
    expect(page).not_to have_button('Marcar como Cancelado')
  end
end
