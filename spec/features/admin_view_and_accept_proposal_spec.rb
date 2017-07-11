require 'rails_helper'

feature 'admin view proposal' do

scenario 'successfully' do

    property = Property.create( city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo',
                                              daily_rate: 90, photo: 'sitio.jpg',
                                              maximum_guests: 5, minimun_rent: 2, maximum_rent: 3,
                                              rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')

    proposal = Proposal.create(start_date: '10/07/2017', end_date: '01/08/2017', daily_rate: 900, property: property, accepted: false)


    visit root_path
    click_on 'Ver propostas'

    expect(page).to have_css('h1', text: 'sitio do meu vo')
    expect(page).to have_css('li', text: '10/07/2017')
    expect(page).to have_css('li', text: '01/08/2017')
    expect(page).to have_css('li', text: '900')
  end


  scenario 'and accepts proposal' do
    property = Property.create( city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo',
                                              daily_rate: 90, photo: 'sitio.jpg',
                                              maximum_guests: 5, minimun_rent: 2, maximum_rent: 3,
                                              rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')

    proposal = Proposal.create(start_date: '10/07/2017', end_date: '01/08/2017', daily_rate: 900, property: property, accepted: false)

    visit root_path
    click_on 'Ver propostas'
    click_on 'sitio do meu vo'
    click_on 'Aceitar'


    expect(page).to have_content('Proposta aceita..')
    expect(page).not_to have_css('h1', text: 'sitio do meu vo')



  end

  scenario 'and property not avaliable on period' do
    property = Property.create( city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo',
                                              daily_rate: 90, photo: 'sitio.jpg',
                                              maximum_guests: 5, minimun_rent: 2, maximum_rent: 3,
                                              rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')

    proposal = Proposal.create(start_date: '10/07/2017', end_date: '01/08/2017', daily_rate: 900, property: property, accepted: true)

    other_property = Property.create( city: 'SaoPaulo', state: 'SP', property_type: 'casa de praia', description: 'casa de praia no guaruja',
                                              daily_rate: 100, photo: 'casa_no_guaruja.jpg',
                                              maximum_guests: 10, minimun_rent: 5, maximum_rent: 3,
                                              rules: 'MUITAS regras e mimimi', rent_purpose: 'carnaval', owner: 'Eliza')

    other_proposal = Proposal.create(start_date: '10/07/2017', end_date: '01/08/2017', daily_rate: 1000, property: property, accepted: false)
    #simula a acao
    visit root_path
    fill_in 'filter', with: 'SaoPaulo'
    click_on 'Filtrar'

    expect(page).not_to have_css('h1', text: 'sitio do meu vo')
    expect(page).to have_css('h1', text: 'casa da praia no guaruja')
  end
end
