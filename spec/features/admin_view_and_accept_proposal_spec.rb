require 'rails_helper'

feature 'admin view proposal' do

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

    visit root_path
    click_on 'Ver propostas'

    expect(page).to have_css('h3', text: property.title)
    expect(page).to have_css('li', text: proposal.start_date.strftime( '%d/%m/%Y'))
    expect(page).to have_css('li', text: proposal.end_date.strftime( '%d/%m/%Y' ))
    expect(page).to have_css('li', text: 'R$ 180,00')
  end

  scenario 'and accepts proposal' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                              observation: 'nao pisar na grama', start_date: 10.days.from_now, end_date: 12.days.from_now,
                              total_amount: 900, property: property, accepted: false, user: owner)

    visit root_path
    click_on 'Ver propostas'
    click_on property.title
    click_on 'Aceitar'

    expect(page).to have_content('Proposta aceita..')
    expect(page).not_to have_css('h3', text: property.title)
  end

  scenario 'and property not avaliable on period' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                              observation: 'nao pisar na grama', start_date: 5.days.from_now, end_date: 16.days.from_now,
                              total_amount: 900, property: property, accepted: false, user: owner)

    other_property = Property.create(title: 'casa da praia', city: 'SaoPaulo', state: 'SP', property_type_id: property_type.id, description: 'casa de praia no guaruja',
                                              daily_rate: 100,
                                              maximum_guests: 10, minimun_rent: 3, maximum_rent: 13,
                                              rules: 'MUITAS regras e mimimi', owner_id: owner)

    PropertyPurpose.create(property: other_property, purpose: purpose)

    other_proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                                              observation: 'nao pisar na grama', start_date: 5.days.from_now, end_date: 16.days.from_now,
                                              total_amount: 900, property: other_property, accepted: true, user: owner)

    #simula a acao
    visit root_path
    click_on property.title
    click_on 'Enviar Proposta'
    fill_in 'Data Inicial', with: 6.days.from_now
    fill_in 'Data Final', with: 15.days.from_now
    fill_in 'Quantidade de hóspedes', with: proposal.total_guests
    fill_in 'Nome', with: proposal.name
    fill_in 'CPF', with: proposal.cpf
    fill_in 'Telefone', with: proposal.phone
    fill_in 'Observações', with: proposal.observation
    fill_in 'Email', with: proposal.email
    click_on 'Enviar'

    expect(page).to have_content('casa indisponivel')
  end

  scenario 'and proposal generate rent' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    proposal = Proposal.create(total_guests: 5, name: 'Eliza', email: 'eliza@rails.com', cpf: '123456789', phone: '67834-1234',
                              observation: 'nao pisar na grama', start_date: 10.days.from_now, end_date: 12.days.from_now,
                              total_amount: 900, property: property, accepted: false, user: owner)

    visit root_path
    click_on 'Ver propostas'
    click_on property.title
    click_on 'Aceitar'

    expect(page).to have_content('Proposta aceita..')
    expect(page).to have_css('li', text: proposal.name)
    expect(page).to have_css('li', text: "Data de aceite: #{I18n.l(Time.zone.now.to_date)}")
    expect(page).to have_css('li', text: property.title)
  end

end
