require 'rails_helper'

feature 'visitor_filter_properties' do
  scenario 'successfully' do
    #cria os dados necessarios
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, city: 'Sao Paulo', property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    another_property = create(:property, city: 'Bauru', property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: another_property, purpose: purpose)

    #simula a acao do usuario
    visit root_path
    fill_in 'filter', with: 'Sao Paulo'
    click_on 'Filtrar'

    expect(page).to have_css('li', text: 'Sao Paulo')
    expect(page).not_to have_css('li', text: 'Rio de Janeiro')
  end
  
  scenario 'and there is no property' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, city: 'Sao Paulo', property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    another_property = create(:property, city: 'Bauru', property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: another_property, purpose: purpose)

    visit root_path
    fill_in 'filter', with: 'Curitiba'
    click_on 'Filtrar'

    expect(page).to have_css('h2', text: 'Nenhum imovel encontrado nessa cidade.')
  end

end
