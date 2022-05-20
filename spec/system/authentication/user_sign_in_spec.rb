require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange
    User.create!(name: 'João Silva', email: 'joao@email.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    within('nav') do
      expect(page).not_to have_link('Entrar')
      expect(page).to have_button('Sair')
      expect(page).to have_content('João Silva - joao@email.com')
    end
    expect(page).to have_content('Login efetuado com sucesso.')
  end

  it 'e faz logout' do
    # Arrange
    User.create!(email: 'joao@email.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    within('nav') do
      expect(page).not_to have_button('Sair')
      expect(page).to have_link('Entrar')
      expect(page).not_to have_content('joao@email.com')
    end
    expect(page).to have_content('Logout efetuado com sucesso.')
  end
end
