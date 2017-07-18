require 'rails_helper'

feature 'User view properties ' do

  scenario ' successfully ' do
    # criar as paradas
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    # simulate parada
    visit root_path

    expect(page).to have_css('h3', text: property.title )
    expect(page).to have_link(property.title)
  end

  scenario 'and view details of properties' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    PropertyPurpose.create(property: property , purpose: purpose )

    visit root_path
    click_on property.title

    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('li', text: property.state)
    expect(page).to have_css('li', text: property.city)
    expect(page).to have_css('li', text: 'R$ 90,00')
    expect(page).to have_css('li', text: property.owner.name)
    expect(page).to have_css('li', text:  property.rules)
    expect(page).to have_css('p', text: property.description)
  end

  scenario 'and expect price up to date' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

     daily_price_range = PriceRange.create(start_date: Date.today, end_date: Date.today + 30, daily_rate: 150, property_id: property.id)

     visit root_path

     click_on property.title

     expect(page).to have_css('h1', text: property.title)
     expect(page).to have_css('li', text: 'R$ 150,00')
  end

end
