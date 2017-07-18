require 'rails_helper'

feature 'Owner add photo to property' do
  scenario 'successfully' do
    property_type = PropertyType.create(name: 'sitio')

    user = User.create(email: 'eliza@rails.com', password: 'test123', name: 'vo Carlos')
    login_as(user)
    purpose = Purpose.create(name:'ferias')

    #simula o cadastro
    visit root_path
    click_on 'Cadastrar Imovel'
    #preencher o form
    fill_in 'Titulo', with: 'sitio do meu vo'
    fill_in 'Cidade', with: 'SaoPaulo'
    fill_in 'Estado', with: 'SP'
    select 'sitio', from: 'Tipo do imovel'
    fill_in 'Preco', with: '90'
    fill_in 'Capacidade', with: '5'
    fill_in 'Maximo de dias para hospedagem', with: '3'
    fill_in 'Minimo de dias para hospedagem', with: '2'
    fill_in 'Regras', with: 'varias regras mimimi'
    check purpose.name
    fill_in 'Descricao', with: 'sitio do meu vo muito bac'
    attach_file('Foto do imóvel', "#{Rails.root}/spec/support/images/sitio.jpg")

    click_on 'Enviar'

    #excepct stranger things
    expect(page).to have_css('h1', text: 'sitio do meu vo')
    expect(page).to have_css('li', text: 'SP')
    expect(page).to have_css('li', text: 'SaoPaulo')
    expect(page).to have_css('li', text: 'sitio')
    expect(page).to have_css('li', text: 'R$ 90,00')
    expect(page).to have_css('li', text: '5')
    expect(page).to have_css('li', text: '3')
    expect(page).to have_css('li', text: '2')
    expect(page).to have_css('li', text: 'varias regras mimimi')
    expect(page).to have_css('li', text: 'ferias')
    expect(page).to have_css('li', text: user.name)
    expect(page).to have_css('p', text: 'sitio do meu vo muito bac')
    expect(page).to have_css("img[src*='sitio.jpg']")
  end

  scenario 'and dont have photo' do
    property_type = PropertyType.create(name: 'sitio')

    user = User.create(email: 'eliza@rails.com', password: 'test123', name: 'vo Carlos')
    login_as(user)

    purpose = Purpose.create(name:'ferias')

    #simula o cadastro
    visit root_path
    click_on 'Cadastrar Imovel'
    #preencher o form
    fill_in 'Titulo', with: 'sitio do meu vo'
    fill_in 'Cidade', with: 'SaoPaulo'
    fill_in 'Estado', with: 'SP'
    select 'sitio', from: 'Tipo do imovel'
    fill_in 'Preco', with: '90'
    fill_in 'Capacidade', with: '5'
    fill_in 'Maximo de dias para hospedagem', with: '3'
    fill_in 'Minimo de dias para hospedagem', with: '2'
    fill_in 'Regras', with: 'varias regras mimimi'
    check purpose.name
    fill_in 'Descricao', with: 'sitio do meu vo muito bac'

    click_on 'Enviar'

    #excepct stranger things
    expect(page).to have_css('h1', text: 'sitio do meu vo')
    expect(page).to have_css('li', text: 'SP')
    expect(page).to have_css('li', text: 'SaoPaulo')
    expect(page).to have_css('li', text: 'sitio')
    expect(page).to have_css('li', text: 'R$ 90,00')
    expect(page).to have_css('li', text: '5')
    expect(page).to have_css('li', text: '3')
    expect(page).to have_css('li', text: '2')
    expect(page).to have_css('li', text: 'varias regras mimimi')
    expect(page).to have_css('li', text: 'ferias')
    expect(page).to have_css('li', text: user.name)
    expect(page).to have_css('p', text: 'sitio do meu vo muito bac')
    expect(page).to have_css("img[src*='missing.jpg']")
  end
end
