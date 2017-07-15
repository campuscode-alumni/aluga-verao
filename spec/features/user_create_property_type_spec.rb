require 'rails_helper'

feature 'User create property type' do
  scenario 'successfully' do
    user = User.create(email: 'eliza@rails.com', password: 'test123')

    visit root_path

    click_on 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    click_on 'Cadastrar tipo de imovel'

    fill_in 'Tipo de imovel', with: 'Apartamento'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Apartamento')
  end

  scenario 'and is missing name' do
    user = User.create(email: 'eliza@rails.com', password: 'test123')

    visit root_path

    click_on 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    click_on 'Cadastrar tipo de imovel'

    fill_in 'Tipo de imovel', with: ''

    click_on 'Enviar'

    expect(page).to have_css('label', text: 'Você deve preencher o nome do tipo de imóvel')
  end
end
