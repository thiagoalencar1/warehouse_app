require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê nome da aplicação' do
    # Arrange

    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê galpões cadastrados' do
    # Arrange
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000)
    Warehouse.create(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000)

    # Act
    visit('/')

    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m²')

    expect(page).to have_content('Maceió')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceió')
    expect(page).to have_content('50000 m²')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange

    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end
