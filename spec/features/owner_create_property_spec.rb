require 'rails_helper'

feature 'Owner create property' do

  scenario 'successfully' do
    property_type = PropertyType.create(name: 'sitio')

    user = User.create(email: 'eliza@rails.com', password: 'test123')

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
    fill_in 'Finalidade', with: 'ferias'
    fill_in 'Dono', with: 'vo Carlos'
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
    expect(page).to have_css('li', text: 'vo Carlos')
    expect(page).to have_css('p', text: 'sitio do meu vo muito bac')

  end

  scenario 'and must fill owner' do
    property_type = PropertyType.create(name: 'sitio')

    visit root_path

    click_on 'Cadastrar Imovel'

    fill_in 'Titulo', with: 'sitio do meu vo'
    fill_in 'Cidade', with: 'SaoPaulo'
    fill_in 'Estado', with: 'SP'
    select 'sitio', from: 'Tipo do imovel'
    fill_in 'Preco', with: '90'
    fill_in 'Capacidade', with: '5'
    fill_in 'Maximo de dias para hospedagem', with: '3'
    fill_in 'Minimo de dias para hospedagem', with: '2'
    fill_in 'Regras', with: 'varias regras mimimi'
    fill_in 'Finalidade', with: 'ferias'
    fill_in 'Dono', with: ''
    fill_in 'Descricao', with: 'sitio do meu vo muito bac'

    click_on 'Enviar'

    expect(page).to have_content('Este imovel nao pode ser cadastrado sem um proprietario')

  end
end
