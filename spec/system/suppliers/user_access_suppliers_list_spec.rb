require 'rails_helper'

describe 'Usuário acessa o menu de fornecedores' do
  it 'e acessa index de fornecedores' do
    # Arrange
    # Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    # Assert
    expect(current_path).to eq suppliers_path
  end

  it 'e vê lista de fornecedores' do
    # Arrange
    Supplier.create!(
      corporate_name: 'A Fantástica Fábrica de Chocolate', brand_name: 'Indústrias Wonka', nif: '0987565343120',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )

    Supplier.create!(
      corporate_name: 'Instituto Xavier para crianças superdotadas', brand_name: 'X-Men', nif: '0312645867089',
      full_address: 'Do lado de minha casa, 14', city: 'Ipiaú', state: 'BA',
      email: 'contato@xmen.com', contact_number: '+557331183804'
    )

    # Act
    visit root_path
    click_on 'Fornecedores'

    # Assert
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('Indústrias Wonka')
    expect(page).to have_content('Salvador - BA')
    expect(page).to have_content('X-Men')
    expect(page).to have_content('Ipiaú - BA')
  end
  it 'e vê mensagem de que não há fornecedores' do
    # Arrange
    # Act
    visit root_path
    click_on('Fornecedores')

    # Assert
    expect(page).to have_content('Nenhum fornecedor cadastrado.')
  end
end
