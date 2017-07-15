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

  scenario 'and edit a property' do
    property_type = PropertyType.create(name: 'sitio')

    property = Property.create( title: 'sitio do meu vo', city: 'SaoPaulo', state: 'SP', property_type_id: property_type.id, description: 'sitio do meu vo muito bac',
                                daily_rate: 90,
                                maximum_guests: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')


    visit root_path
    click_on 'sitio do meu vo'
    click_on 'Editar'

    fill_in 'Titulo', with: 'Casa de campo'
    fill_in 'Descricao', with: 'Casa de campo para temporada'
    fill_in 'Cidade', with: 'Niteroi'
    fill_in 'Estado', with: 'RJ'
    select 'sitio', from: 'Tipo do imovel'
    fill_in 'Preco', with: '100'
    fill_in 'Capacidade', with: '10'
    fill_in 'Maximo de dias para hospedagem', with: '9'
    fill_in 'Minimo de dias para hospedagem', with: '3'
    fill_in 'Regras', with: 'nao sujar a casa'
    fill_in 'Finalidade', with: 'ferias'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Casa de campo')
    expect(page).to have_css('li', text: 'Niteroi')
    expect(page).to have_css('li', text: 'RJ')
  end

  scenario 'and edit a property editing photo' do
    property_type = PropertyType.create(name: 'sitio')

    photo = File.new("#{Rails.root}/spec/support/images/sitio.jpg")

    property = Property.create( title: 'sitio do meu vo', city: 'SaoPaulo', state: 'SP', property_type_id: property_type.id, description: 'sitio do meu vo muito bac',
                                daily_rate: 90,
                                maximum_guests: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos',
                                photo: photo)

    visit root_path
    click_on 'sitio do meu vo'
    click_on 'Editar'

    fill_in 'Titulo', with: 'Casa de campo'
    fill_in 'Descricao', with: 'Casa de campo para temporada'
    fill_in 'Cidade', with: 'Niteroi'
    fill_in 'Estado', with: 'RJ'
    select 'sitio', from: 'Tipo do imovel'
    fill_in 'Preco', with: '100'
    fill_in 'Capacidade', with: '10'
    fill_in 'Maximo de dias para hospedagem', with: '9'
    fill_in 'Minimo de dias para hospedagem', with: '3'
    fill_in 'Regras', with: 'nao sujar a casa'
    fill_in 'Finalidade', with: 'ferias'
    attach_file('Foto do imóvel', "#{Rails.root}/spec/support/images/sitio2.jpg")

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Casa de campo')
    expect(page).to have_css('li', text: 'Niteroi')
    expect(page).to have_css('li', text: 'RJ')
    expect(page).to have_css("img[src*='sitio2.jpg']")
  end
end
