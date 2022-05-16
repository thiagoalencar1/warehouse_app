require 'rails_helper'

describe 'Usuário cadastra um novo Modelo de Produto' do
  it 'com sucesso' do
    # Arrange
    supplier1 = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
      full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
      email: 'sac@lg.com', contact_number: '123456789'
    )

    supplier2 = Supplier.create!(
      brand_name: 'Apple', corporate_name: 'Apple Inc.', nif: '00011122233344',
      full_address: 'Av. 19 de outubro', city: 'Ipiaú', state: 'BA',
      email: 'sac@apple.com', contact_number: '123456789'
    )

    # Act
    visit root_path
    click_on 'Modelos de Produto'
    click_on 'Cadastrar Modelo de Produto'
    fill_in 'Nome', with: 'Boombox SoundBox'
    fill_in 'Peso', with: 500
    fill_in 'Largura', with: 5
    fill_in 'Altura', with: 15
    fill_in 'Profundidade', with: 5
    fill_in 'SKU', with: 'LGBOOM-45670-1234567'
    select 'LG', from: 'Fornecedor'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq product_model_path(supplier1.id)
    expect(page).to have_content('Modelo de Produto cadastrado com sucesso.')
    expect(page).to have_content('Boombox SoundBox')
    expect(page).to have_content('Peso: 0,500 kg')
    expect(page).to have_content('Altura: 15 cm')
    expect(page).to have_content('Largura: 5 cm')
    expect(page).to have_content('SKU: LGBOOM-45670-1234567')
    expect(page).to have_content('Fornecedor: LG')
  end

  it 'deve preencher todos os campos' do
    # Arrange
    Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
      full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
      email: 'sac@lg.com', contact_number: '123456789'
    )

    # Act
    visit root_path
    click_on 'Modelos de Produto'
    click_on 'Cadastrar Modelo de Produto'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Todos campos devem ser preenchidos corretamente.')
  end
end
