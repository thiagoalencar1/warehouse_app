require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do
    # Arrange
    user = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')

    # Act
    login_as(user, scope: :user)
    visit root_path

    # Assert
    within('nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'e deve estar logado' do
    # Arrange
    # Act
    visit root_path

    # Assert
    within('nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end

  it 'e encontra um pedido' do
    # Arrange
    user = User.create!(name: 'Manoel', email: 'manoel@email.com', password: '123456')
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'Fábrica de Chocolate LTDA', brand_name: 'Indústrias Wonka', nif: '09875653431200',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(user, scope: :user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    # Assert
    expect(page).to have_content("Resultados da busca: #{order.code}")
    expect(page).to have_content('1 pedido encontrado')
    expect(page).to have_content("Código: #{order.code}")
    expect(page).to have_content("Galpão Destino: #{warehouse.full_description}")
    expect(page).to have_content("Fornecedor: #{supplier.corporate_name}")
  end
end
