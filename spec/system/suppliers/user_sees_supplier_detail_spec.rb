require 'rails_helper'

describe 'Usuário acessa detalhes de um fornecedor' do
  it 'e vê mais informações' do
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

    # Assert
    expect(page).to have_content('A Fantástica Fábrica de Chocolate')
    expect(page).to have_content('NIF: 0987565343120')
    expect(page).to have_content('Cidade: Salvador')
    expect(page).to have_content('Estado: BA')
    expect(page).to have_content('Email: contato@wonka.com')
    expect(page).to have_content('Número de Contato: +557133224455')
  end

  it 'e volta para a lista de Fornecedores ' do
    # Arrange
    Supplier.create!(
      corporate_name: 'Instituto Xavier para crianças superdotadas', brand_name: 'X-Men', nif: '3126458670890',
      full_address: 'Do lado de minha casa, 14', city: 'Ipiaú', state: 'BA',
      email: 'contato@xmen.com', contact_number: '+557331183804'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'X-Men'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq suppliers_path
  end
end
