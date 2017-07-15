require 'rails_helper'

feature 'Owner edit daily price range' do
  scenario 'successfully' do

    purpose = Purpose.create(name:'ferias')


    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão',  owner: 'vo Carlos')

    PropertyPurpose.create(property: property , purpose: purpose )

    daily_price_range = PriceRange.create(start_date: Date.today, end_date: Date.today + 30, daily_rate: 100, property_id: property.id)

    visit root_path
    click_on 'Meus imoveis'
    click_on 'Editar preços'
    click_on 'Editar periodo'

    fill_in 'Valor da diaria', with: '150,00'
    click_on 'Enviar'

    expect(page).to have_css('li', text: I18n.l(daily_price_range.start_date))
    expect(page).to have_css('li', text: I18n.l(daily_price_range.end_date))
    expect(page).to have_css('li', text: 'R$ 150,00')
  end
  scenario 'and is missing price' do

    purpose = Purpose.create(name:'ferias')


    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', owner: 'vo Carlos')

    PropertyPurpose.create(property: property , purpose: purpose )

    daily_price_range = PriceRange.create(start_date: Date.today, end_date: Date.today + 30, daily_rate: 100, property_id: property.id)

    visit root_path
    click_on 'Meus imoveis'
    click_on 'Editar preços'
    click_on 'Editar periodo'

    fill_in 'Valor da diaria', with: ''
    click_on 'Enviar'

    expect(page).to have_css('label', text: 'Houve um erro ao tentar editar o preço por periodo')
  end
end
