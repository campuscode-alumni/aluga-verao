require 'rails_helper'

feature 'User view properties ' do

  scenario ' successfully ' do
    # criar as paradas
    property = Property.create(title: 'AP Top', city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo', daily_rate: 90.0, photo: 'sitio.jpg',
                                maximum_guests: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')
    # simulate parada
    visit root_path

    expect(page).to have_css('h1', text: 'sitio do meu vo' )
    expect(page).to have_link('sitio do meu vo')
  end

  scenario 'and view details of properties' do
    property = Property.create( title: 'Apartamento muito louco', city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo', daily_rate: 90.0, photo: 'sitio.jpg',
                                maximum_guests: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')

    visit root_path

    click_on 'sitio do meu vo'

    expect(page).to have_css('h1', text: property.description)

    expect(page).to have_css('li', text: property.state)
    expect(page).to have_css('li', text: property.city)
    expect(page).to have_css('li', text: property.daily_rate)
    expect(page).to have_css('li', text: property.owner)
    expect(page).to have_css('li', text:  property.rules)

  end
end
