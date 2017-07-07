require 'rails_helper'

feature 'User view properties ' do

  scenario ' successfully ' do
    # criar as paradas
    property = Property.create( city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo', price: 90.0, photo: 'sitio.jpg',
                                capacity: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')
    # simulate parada
    visit root_path

    expect(page).to have_css('h1', text: 'sitio do meu vo' )
    expect(page).to have_link('sitio do meu vo')
  end

end
