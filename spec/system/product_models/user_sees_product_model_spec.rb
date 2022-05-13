require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'a partir do menu' do
    # Arrange
    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    # Arrange
    supplier = Supplier.new(
      brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '12345678901290',
      full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
      email: 'vemnimim@lg.com', contact_number: '123456789'
    )

    ProductModel.create!(
      name: 'Monitor UltraWide 29\'', weight: 5290, width: 70, height: 45, depth: 5,
      sku: 'LG29wk600-1234-RTGH6', supplier:
    )

    ProductModel.create!(
      name: 'Boombox SoundBox', weight: 500, width: 5, height: 15, depth: 5,
      sku: 'LGBOOM-45670-876-YTH', supplier:
    )

    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(page).to have_content 'Monitor UltraWide 29\''
    expect(page).to have_content 'LG29wk600'
    expect(page).to have_content 'LG'

    expect(page).to have_content 'Boombox SoundBox'
    expect(page).to have_content 'LGBOOM-45670'
    expect(page).to have_content 'LG'
  end

  it 'a partir do menu' do
    # Arrange
    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(current_path).to eq product_models_path
  end

  it 'não existem produtos cadastrados' do
    # Arrange
    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    # Assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado.'
  end
end
