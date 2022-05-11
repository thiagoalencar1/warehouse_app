require 'rails_helper'

describe 'Usuário registra um novo fornecedor' do
  it 'com sucesso' do
    # Arrange
    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: 'A Fantástica Fábrica de Chocolate'
    fill_in 'Nome Fantasia', with: 'A Fantástica Fábrica de Chocolate'
    fill_in 'NIF', with: '1234567890123'
    fill_in 'Cidade', with: 'Salvador'
    fill_in 'Estado', with: 'BA'
    fill_in 'Email', with: 'contato@wonka.com'
    fill_in 'Número de Contato', with: '+557133224455'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Fornecedor cadastrado com sucesso.')
    expect(page).to have_content('A Fantástica Fábrica de Chocolate')
  end

  it 'com dados incompletos' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'Email', with: 'xuxubeleza@gmail.com'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Todos campos devem ser preenchidos corretamente.')
  end
end
