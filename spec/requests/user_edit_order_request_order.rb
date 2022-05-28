require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e não é o dono' do
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
    patch(order_path(order.id), params: { order: { supplier_id: 3 } })

    # Assert
    expect(response).to redirect_to(root_path)
  end
end
