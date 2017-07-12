require 'rails_helper'

feature 'admin view proposal' do

scenario 'successfully' do

    property = Property.create( title: 'sitio do meu vo', city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo',
                                              daily_rate: 90, photo: 'sitio.jpg',
                                              maximum_guests: 5, minimun_rent: 2, maximum_rent: 10,
                                              rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                              observation: 'nao pisar na grama', start_date: 10.days.from_now, end_date: 12.days.from_now,
                              total_amount: 900, property: property, accepted: false)


    visit root_path
    click_on 'Ver propostas'

    expect(page).to have_content('sitio do meu vo')
    expect(page).to have_css('h1', text: 'sitio do meu vo')
    expect(page).to have_css('li', text: proposal.start_date.strftime( '%d/%m/%Y'))
    expect(page).to have_css('li', text: proposal.end_date.strftime( '%d/%m/%Y' ))
    expect(page).to have_css('li', text: proposal.total_amount)
  end


  scenario 'and accepts proposal' do
    property = Property.create(title: 'sitio do meu vo', city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo',
                                              daily_rate: 90, photo: 'sitio.jpg',
                                              maximum_guests: 5, minimun_rent: 2, maximum_rent: 10,
                                              rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                              observation: 'nao pisar na grama', start_date: 10.days.from_now, end_date: 12.days.from_now,
                              total_amount: 900, property: property, accepted: false)

    visit root_path
    click_on 'Ver propostas'
    click_on 'sitio do meu vo'
    click_on 'Aceitar'


    expect(page).to have_content('Proposta aceita..')
    expect(page).not_to have_css('h1', text: 'sitio do meu vo')



  end

  scenario 'and property not avaliable on period' do
    property = Property.create(title: 'sitio do meu vo', city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo',
                                              daily_rate: 90, photo: 'sitio.jpg',
                                              maximum_guests: 5, minimun_rent: 2, maximum_rent: 10,
                                              rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                              observation: 'nao pisar na grama', start_date: 10.days.from_now, end_date: 12.days.from_now,
                              total_amount: 900, property: property, accepted: false)

    other_property = Property.create(title: 'casa da praia', city: 'SaoPaulo', state: 'SP', property_type: 'casa de praia', description: 'casa de praia no guaruja',
                                              daily_rate: 100, photo: 'casa_no_guaruja.jpg',
                                              maximum_guests: 10, minimun_rent: 5, maximum_rent: 3,
                                              rules: 'MUITAS regras e mimimi', rent_purpose: 'carnaval', owner: 'Eliza')

    other_proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                                              observation: 'nao pisar na grama', start_date: 10.days.from_now, end_date: 12.days.from_now,
                                              total_amount: 900, property: other_property, accepted: true)

    #simula a acao
    visit root_path
    click_on 'sitio do meu vo'
    click_on 'Enviar'
    fill_in 'Inicio', with: proposal.start_date.strftime( '%d/%m/%Y')
    fill_in 'Termino', with: proposal.end_date.strftime( '%d/%m/%Y')
    fill_in 'Valor', with: '900'
    # fill_in 'Numero de pessoas', text: '10'
    click_on 'Confirmar'


    expect(page).to have_content('casa indisponivel')
  end
end
