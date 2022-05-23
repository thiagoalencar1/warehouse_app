require 'rails_helper'

describe 'um teste qualquer' do
  it 'para ver um erro peculiar' do
    visit root_path
    click_on 'Cidades'
    expect(page).to have_content('Salvador')
  end
end
