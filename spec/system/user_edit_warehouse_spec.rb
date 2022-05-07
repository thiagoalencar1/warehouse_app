require 'rails_helper'

describe 'Usuários edita um galpão' do
  it 'a partir da página de detalhes' do
    # Arrange
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, cep: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    # Assert
    expect(page).to have_field('Nome', with: 'Aeroporto SP')
    expect(page).to have_field('Descrição', with: 'Galpão destinado a cargas internacionais')
    expect(page).to have_field('Código', with: 'GRU')
    expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 100')
    expect(page).to have_field('Cidade', with: 'Guarulhos')
    expect(page).to have_field('CEP', with: '15000-000')
    expect(page).to have_field('Área', with: '100000')
  end

  it 'com sucesso' do
    # Arrange
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, cep: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    fill_in 'Nome', with: 'Galpão Internacional'
    fill_in 'Área', with: '550000'
    fill_in 'Endereço', with: 'Avenida Paulista, 9999'
    fill_in 'CEP', with: '13000-000'

    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Galpão atualizado com sucesso.')
    expect(page).to have_content('Nome: Galpão Internacional')
    expect(page).to have_content('Área: 550000')
    expect(page).to have_content('Avenida Paulista, 9999')
    expect(page).to have_content('CEP: 13000-000')
  end

  it 'sem sucesso' do
    # Arrange
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, cep: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Área', with: ''

    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Atualização não realizada. Verifique os campos em vermelho.')
  end
end
