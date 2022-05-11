require 'rails_helper'

describe 'Usuário acessa detalhes de um Modelo de Produto' do
  it 'e vê mais informações' do
    # Arrange
    supplier = Supplier.new(
      brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '1234567890129',
      full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
      email: 'vemnimim@lg.com', contact_number: '123456789'
    )

    ProductModel.create!(
      name: 'Monitor UltraWide 29\'', weight: 5290, width: 70, height: 45, depth: 5,
      sku: 'LG29wk600', supplier:
    )

    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Monitor UltraWide 29\''

    # Assert
    expect(page).to have_content('Monitor UltraWide 29\'')
    expect(page).to have_content('5,290 kg')
    expect(page).to have_content('70 cm')
    expect(page).to have_content('45 cm')
    expect(page).to have_content('5 cm')
    expect(page).to have_content('LG29wk600')
    expect(page).to have_content('LG')
  end

  it 'e volta para a lista de Modelos de Produto' do
    # Arrange
    supplier = Supplier.new(
      brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '1234567890129',
      full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
      email: 'vemnimim@lg.com', contact_number: '123456789'
    )

    ProductModel.create!(
      name: 'Monitor UltraWide 29\'', weight: 5290, width: 70, height: 45, depth: 5,
      sku: 'LG29wk600', supplier:
    )

    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Monitor UltraWide 29\''
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq product_models_path
  end
end
