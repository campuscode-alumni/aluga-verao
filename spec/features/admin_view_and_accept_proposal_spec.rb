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
    expect(page).to have_css('h3', text: 'sitio do meu vo')
    expect(page).to have_css('li', text: proposal.start_date.strftime( '%d/%m/%Y'))
    expect(page).to have_css('li', text: proposal.end_date.strftime( '%d/%m/%Y' ))
    expect(page).to have_css('li', text: 'R$ 180,00')
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
    expect(page).not_to have_css('h3', text: 'sitio do meu vo')
  end

  scenario 'and property not avaliable on period' do
    property = Property.create(title: 'sitio do meu vo', city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo',
                                              daily_rate: 90, photo: 'sitio.jpg',
                                              maximum_guests: 5, minimun_rent: 2, maximum_rent: 20,
                                              rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                              observation: 'nao pisar na grama', start_date: 5.days.from_now, end_date: 16.days.from_now,
                              total_amount: 900, property: property, accepted: true)

    other_property = Property.create(title: 'casa da praia', city: 'SaoPaulo', state: 'SP', property_type: 'casa de praia', description: 'casa de praia no guaruja',
                                              daily_rate: 100, photo: 'casa_no_guaruja.jpg',
                                              maximum_guests: 10, minimun_rent: 5, maximum_rent: 3,
                                              rules: 'MUITAS regras e mimimi', rent_purpose: 'carnaval', owner: 'Eliza')

    other_proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                                              observation: 'nao pisar na grama', start_date: 5.days.from_now, end_date: 16.days.from_now,
                                              total_amount: 900, property: other_property, accepted: true)

    #simula a acao
    visit root_path
    click_on 'sitio do meu vo'
    click_on 'Enviar'
    fill_in 'Data Inicial', with: 6.days.from_now
    fill_in 'Data Final', with: 15.days.from_now
    fill_in 'Quantidade de hóspedes', with: proposal.total_guests
    fill_in 'Nome', with: proposal.name
    fill_in 'CPF', with: proposal.cpf
    fill_in 'Telefone', with: proposal.phone
    fill_in 'Observações', with: proposal.observation
    fill_in 'Email', with: proposal.email
    #fill_in 'Valor', with: '900'
    # fill_in 'Numero de pessoas', text: '10'
    click_on 'Enviar'


    expect(page).to have_content('casa indisponivel')
  end
end