require 'rails_helper'

feature 'visitor_filter_properties' do
  scenario 'successfully' do
    #cria os dados necessarios
    property = Property.create(city: 'Sao Paulo', state: 'SP', property_type: 'Apartamento', description: 'Apartamento grande na região do Paraisópolis',
                              price: 50, photo: 'apartamento.png', capacity: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão')

    property = Property.create(city: 'Rio de Janeiro', state: 'RJ', property_type: 'Apartamento', description: 'Apartamento grande na região de Copacabana',
                              price: 50, photo: 'apartamento.png', capacity: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão em qualquer lugar do Rio', rent_purpose: 'Pancadão')

    #simula a acao do usuario
    visit root_path
    fill_in 'Filtro', with: 'Sao Paulo'
    click_on 'Filtrar'

    expect(page).to have_css('h1', text: 'Sao Paulo')
    expect(page).not_to have_css('h1', text: 'Rio de Janeiro')
  end

end
