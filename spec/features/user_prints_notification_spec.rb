require 'rails_helper'

feature 'User prints notificaiton' do

  scenario 'successfully' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)


    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                               observation: 'nao pisar na grama', start_date: 5.days.from_now, end_date: 16.days.from_now,
                               total_amount: 900, property: property, accepted: true, user: owner)

    visit root_path
    click_on 'Minhas propostas'
    click_on 'Imprimir Comprovante'

    expect(page).to have_content( owner.name)
    expect(page).to have_content( proposal.cpf )
    expect(page).to have_content( property.owner.name )
    expect(page).to have_content( proposal.start_date )
    expect(page).to have_content( proposal.end_date )
  end

end
