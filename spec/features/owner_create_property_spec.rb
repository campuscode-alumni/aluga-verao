require 'rails_helper'

feature 'Owner create property' do

  scenario 'successfully' do

    #criar um imovel
    property = Property.create(  title: 'sitio do meu vo', city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo muito bac', daily_rate: 90, photo: 'sitio.jpg',
                                maximum_guests: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')



    #simula o cadastro
    visit root_path
    click_on 'Cadastrar Imovel'
    #preencher o form
    fill_in 'Titulo', with: property.title
    fill_in 'Cidade', with: property.city
    fill_in 'Estado', with: property.state
    fill_in 'Tipo', with: property.property_type
    fill_in 'Preco', with: property.daily_rate
    fill_in 'Capacidade', with: property.maximum_guests
    fill_in 'Maximo de dias para hospedagem', with: property.maximum_rent
    fill_in 'Minimo de dias para hospedagem', with: property.minimun_rent
    fill_in 'Regras', with: property.rules
    fill_in 'Finalidade', with: property.rent_purpose
    fill_in 'Dono', with: property.owner
    fill_in 'Descricao', with: property.description

    click_on 'Enviar'

    #excepct stranger things
    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('li', text: property.state)
    expect(page).to have_css('li', text: property.city)
    expect(page).to have_css('li', text: property.property_type)
    expect(page).to have_css('li', text: 'R$ 90,00')
    expect(page).to have_css('li', text: property.maximum_guests)
    expect(page).to have_css('li', text: property.maximum_rent)
    expect(page).to have_css('li', text: property.minimun_rent)
    expect(page).to have_css('li', text: property.rules)
    expect(page).to have_css('li', text: property.rent_purpose)
    expect(page).to have_css('li', text: property.owner)
    expect(page).to have_css('p', text: property.description)

  end

  scenario 'and must fill owner' do

    property = Property.new( city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo', daily_rate: 90.0, photo: 'sitio.jpg',
                                maximum_guests: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias')


    visit root_path

    click_on 'Cadastrar Imovel'
    fill_in 'Descricao', with: property.description
    fill_in 'Cidade', with: property.city
    fill_in 'Estado', with: property.state
    fill_in 'Tipo', with: property.property_type
    fill_in 'Preco', with: property.daily_rate
    fill_in 'Capacidade', with: property.maximum_guests
    fill_in 'Maximo de dias para hospedagem', with: property.maximum_rent
    fill_in 'Minimo de dias para hospedagem', with: property.minimun_rent
    fill_in 'Regras', with: property.rules
    fill_in 'Finalidade', with: property.rent_purpose

    click_on 'Enviar'

    expect(page).to have_content('Este imovel nao pode ser cadastrado sem um proprietario')

  end

  scenario 'and edit a property' do
    property = Property.create(  title: 'sitio do meu vo', city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo muito bac', daily_rate: 90, photo: 'sitio.jpg',
                                maximum_guests: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')


    visit root_path
    click_on 'sitio do meu vo'
    click_on 'Editar'

    fill_in 'Titulo', with: 'Casa de campo'
    fill_in 'Descricao', with: 'Casa de campo para temporada'
    fill_in 'Cidade', with: 'Niteroi'
    fill_in 'Estado', with: 'RJ'
    fill_in 'Tipo', with: 'Casa'
    fill_in 'Preco', with: '100'
    fill_in 'Capacidade', with: '10'
    fill_in 'Max Pessoas', with: '9'
    fill_in 'Min Pessoas', with: '3'
    fill_in 'Regras', with: 'nao sujar a casa'
    fill_in 'Finalidade', with: 'ferias'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Casa de campo')
    expect(page).to have_css('li', text: 'Niteroi')
    expect(page).to have_css('li', text: 'RJ')


  end
end
