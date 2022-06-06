require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela de um galpão' do
    # Arrange

    user = User.create!(name: 'Antônio', email: 'antonio@email.com', password: 'password')

    w = Warehouse.create(
      name: 'Aeroporto SP', code: 'GRU',
      city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 100', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais'
    )

    supplier = Supplier.new(
      brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
      full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
      email: 'vemnimim@lg.com', contact_number: '123456789'
    )

    order = Order.create!(
      user: user, supplier: supplier, warehouse: w,
      estimated_delivery_date: 1.day.from_now
    )

    produto_monitor = ProductModel.create!(
      name: 'Monitor UltraWide 29\'', weight: 5290, width: 70, height: 45, depth: 5,
      sku: 'LG29wk600-1234-RTGH6', supplier: supplier
    )

    produto_soundbar = ProductModel.create!(
      name: 'Boombox SoundBox', weight: 500, width: 5, height: 15, depth: 5,
      sku: 'LGBOOM-45670-876-YTH', supplier: supplier
    )

    produto_notebook = ProductModel.create!(
      name: 'Notebook i5 16GB RAM', weight: 2000, width: 40, height: 16, depth: 20,
      sku: 'LGNOTE-55000-976-HGI', supplier: supplier
    )

    3.times { StockProduct.create!(order: order, warehouse: w, product_model: produto_monitor) }
    2.times { StockProduct.create!(order: order, warehouse: w, product_model: produto_notebook) }

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    within("section#stock_products") do 
      expect(page).to have_content 'Itens em Estoque'
      expect(page).to have_content '3 x LG29wk600-1234-RTGH6'
      expect(page).to have_content '2 x LGNOTE-55000-976-HGI'
      expect(page).not_to have_content 'LGBOOM-45670-876-YTH'
    end
  end

  it 'e dá baixa em um item' do
    # Arrange

    user = User.create!(name: 'Antônio', email: 'antonio@email.com', password: 'password')

    w = Warehouse.create(
      name: 'Aeroporto SP', code: 'GRU',
      city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 100', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais'
    )

    supplier = Supplier.new(
      brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
      full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
      email: 'vemnimim@lg.com', contact_number: '123456789'
    )

    order = Order.create!(
      user: user, supplier: supplier, warehouse: w,
      estimated_delivery_date: 1.day.from_now
    )

    produto_monitor = ProductModel.create!(
      name: 'Monitor UltraWide 29\'', weight: 5290, width: 70, height: 45, depth: 5,
      sku: 'LG29wk600-1234-RTGH6', supplier: supplier
    )

    2.times { StockProduct.create!(order: order, warehouse: w, product_model: produto_monitor) }

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Aeroporto SP'
    select 'LG29wk600-1234-RTGH6', from: 'Item para saída'
    fill_in 'Destinatário', with: 'Maria da Silva'
    fill_in 'Endereço Destino', with: 'Rua do Destino, 100. Mucugê.'
    click_on 'Confirmar Retirada'

    # Assert
    expect(current_path).to eq warehouse_path(w.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1 x LG29wk600-1234-RTGH6'
  end

end