require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    # Arrange
    warehouse = Warehouse.create!(
      name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
      address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
    )

    # Act
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content('Galpão excluído com sucesso.')
    expect(page).not_to have_content('Cuiabá')
    expect(page).not_to have_content('CWB')
  end

  it 'não apaga outros galpões' do
    # Arrange
    warehouse1 = Warehouse.create!(
      name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
      address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
    )
    warehouse1 = Warehouse.create!(
      name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000,
      postal_code: '46000-000', address: 'Avenida Tiradentes, 42',
      description: 'Galpão no centro do país'
    )

    # Act
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content('Galpão excluído com sucesso.')
    expect(page).to have_content('Belo Horizonte')
    expect(page).not_to have_content('Cuiabá')
  end
end
