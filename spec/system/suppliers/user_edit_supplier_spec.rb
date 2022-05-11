require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'com sucesso' do
    # Arrange
    Supplier.create!(
      corporate_name: 'A Fantástica Fábrica de Chocolate', brand_name: 'Indústrias Wonka', nif: '0987565343120',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Indústrias Wonka'
    click_on 'Editar'

    fill_in 'Razão Social', with: 'Apenas uma Fábrica de Chocolate'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'

    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Fornecedor atualizado com sucesso')
    expect(page).to have_content('Apenas uma Fábrica de Chocolate')
    expect(page).to have_content('São Paulo - SP')
  end

  it 'sem sucesso' do
    # Arrange
    Supplier.create!(
      corporate_name: 'A Fantástica Fábrica de Chocolate', brand_name: 'Indústrias Wonka', nif: '0987565343120',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Indústrias Wonka'
    click_on 'Editar'

    fill_in 'NIF', with: '1234567890bfa'

    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Atualização não realizada.')
  end
end
