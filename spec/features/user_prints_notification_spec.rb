require 'rails_helper'

feature 'User prints notificaiton' do

  scenario 'successfully' do

    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'casa da praia', city: 'SaoPaulo', state: 'SP', property_type_id: property_type.id, description: 'casa de praia no guaruja',
                              daily_rate: 100,
                              maximum_guests: 10, minimun_rent: 5, maximum_rent: 20,
                              rules: 'MUITAS regras e mimimi', owner: 'Eliza')

    purpose = Purpose.create(name:'ferias')

    PropertyPurpose.create(property: property , purpose: purpose )

    user = User.create(email: 'eliza@rails.com', password: 'test123')

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                               observation: 'nao pisar na grama', start_date: 5.days.from_now, end_date: 16.days.from_now,
                               total_amount: 900, property: property, accepted: true, user: user)


    visit root_path

    click_on 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    visit root_path
    click_on 'Minhas propostas'
    click_on 'Imprimir Comprovante'

    expect(page).to have_content( user.name)
    expect(page).to have_content( proposal.cpf )
    expect(page).to have_content( property.owner )
    expect(page).to have_content( proposal.start_date )
    expect(page).to have_content( proposal.end_date )

  end

end
