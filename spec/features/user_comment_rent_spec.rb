require 'rails_helper'

feature 'User comment rent' do

  scenario 'successfully' do

    user = User.create(email: 'eliza@rails.com', password: 'test123')
    purpose = Purpose.create(name:'ferias')

    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'sitio do meu vo', city: 'SaoPaulo', state: 'SP', property_type_id: property_type.id, description: 'sitio do meu vo',
                                              daily_rate: 90,
                                              maximum_guests: 5, minimun_rent: 2, maximum_rent: 10,
                                              rules: 'varias regras mimimi',owner: 'vo Carlos')

    PropertyPurpose.create(property: property , purpose: purpose )

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                              observation: 'nao pisar na grama', start_date: 10.days.from_now, end_date: 12.days.from_now,
                              total_amount: 900, property: property, accepted: false, user: user)

    rent = Rent.create( proposal: proposal)

    login_as(user)

    visit root_path
    click_on 'Minhas locações'
    click_on 'Avaliar'

    select '6', from: 'Nota'
    fill_in 'Comentario', with: 'Que bonita sua roupa, que roupinhas muito loca'
    click_on 'Enviar'

    expect(page).to have_content('Avaliacao enviada com sucesso')

  end
end
