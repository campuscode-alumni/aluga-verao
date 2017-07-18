require 'rails_helper'

feature 'User comment rent' do

  scenario 'successfully' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                              observation: 'nao pisar na grama', start_date: 10.days.from_now, end_date: 12.days.from_now,
                              total_amount: 900, property: property, accepted: false, user: owner)

    rent = Rent.create( proposal: proposal)

    visit root_path
    click_on 'Minhas locações'
    click_on 'Avaliar'

    select '6', from: 'Nota'
    fill_in 'Comentario', with: 'Que bonita sua roupa, que roupinhas muito loca'
    click_on 'Enviar'

    expect(page).to have_content('Avaliacao enviada com sucesso')
  end
end
