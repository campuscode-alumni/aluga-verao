require 'rails_helper'

feature 'visitor_send_proposal' do
  scenario 'successfully' do
    #cria os dados necessarios
    property_type = PropertyType.create(name: 'sitio')
    user = User.create(email: 'eliza@rails.com', password: 'test123')
    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

    #proposal = Proposal.create(start_date: Date.new(2017, 5, 12), end_date: Date.new(2017, 5,17),
    #                            total_amount: 200.00, total_guests: 4, name: 'Fernando da Silva',
    #                            email: 'fernando@silva.com', cpf: '12345678901', phone: '45810809',
    #                            observation: 'Pretendo levar dois cachorros')
    visit root_path

    click_on 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'


    visit root_path
    click_on 'Apartamento Top'
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '05/09/2017'
    fill_in 'Data Final', with: '10/09/2017'
    fill_in 'Quantidade de hóspedes', with: '4'
    fill_in 'Nome', with: 'Fernando da Silva'
    fill_in 'Email', with: 'fernado@silva.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11)99899-0909'
    fill_in 'Observações', with: 'Pretendo levar dois cachorros e um gato'

    click_on 'Enviar'

    expect(page).to have_css('li', text: '05/09/2017')
    expect(page).to have_css('li', text: '10/09/2017')
    expect(page).to have_css('li', text: 'Valor total: R$ 250,00')
  end

  scenario 'and missing some attribute' do
    #criando os dados necessarios
    property_type = PropertyType.create(name: 'sitio')
    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

    visit root_path
    click_on 'Apartamento Top'
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: ''
    fill_in 'Data Final', with: ''
    fill_in 'Nome',  with: ''
    fill_in 'Email', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'Observações', with: ''
    click_on 'Enviar'

    expect(page).to have_css('label', text: 'Houve um erro ao tentar enviar a proposta')
  end

  scenario 'and start date < today' do
    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

    visit root_path
    click_on 'Apartamento Top'
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '2017-07-10'
    fill_in 'Data Final', with: '2017-07-15'
    fill_in 'Quantidade de hóspedes', with: 5
    fill_in 'Nome', with: 'Carlos Alberto'
    fill_in 'Email', with: 'carlos.alberto@gmail.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11) 99899-0909'
    fill_in 'Observações', with: 'Pretendo levar um cachorro'
    click_on 'Enviar'

    expect(page).to have_css('label', text: 'Data inicial deve ser maior do que a data de hoje')

  end
  scenario 'and end date < start date' do
    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

    visit root_path
    click_on 'Apartamento Top'
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: Date.today + 1
    fill_in 'Data Final', with: '2017-07-09'
    fill_in 'Quantidade de hóspedes', with: 5
    fill_in 'Nome', with: 'Carlos Alberto'
    fill_in 'Email', with: 'carlos.alberto@gmail.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11) 99899-0909'
    fill_in 'Observações', with: 'Pretendo levar um cachorro'
    click_on 'Enviar'

    expect(page).to have_css('label', text: 'Data final deve ser maior do que a data inicial')
  end

  scenario 'and total days < minimun rent' do
    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

    visit root_path
    click_on 'Apartamento Top'
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '2017-09-11'
    fill_in 'Data Final', with: '2017-09-11'
    fill_in 'Quantidade de hóspedes', with: 5
    fill_in 'Nome', with: 'Carlos Alberto'
    fill_in 'Email', with: 'carlos.alberto@gmail.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11) 99899-0909'
    fill_in 'Observações', with: 'Pretendo levar um cachorro'
    click_on 'Enviar'

    expect(page).to have_css('label', text: "Quantidade de dias para hospedagem precisa ser maior que #{property.minimun_rent}")
  end

  scenario 'and total days > maximumn rent' do
    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

    visit root_path
    click_on 'Apartamento Top'
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '2017-09-11'
    fill_in 'Data Final', with: '2017-09-18'
    fill_in 'Quantidade de hóspedes', with: 5
    fill_in 'Nome', with: 'Carlos Alberto'
    fill_in 'Email', with: 'carlos.alberto@gmail.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11) 99899-0909'
    fill_in 'Observações', with: 'Pretendo levar um cachorro'
    click_on 'Enviar'

    expect(page).to have_css('label', text: "Quantidade de dias para hospedagem precisa ser menor que #{property.maximum_rent}")
  end

  scenario 'and expect price up to date' do
    property_type = PropertyType.create(name: 'sitio')

    user = User.create(email: 'eliza@rails.com', password: 'test123')

    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

    daily_price_range = PriceRange.create(start_date: Date.today, end_date: Date.today + 30, daily_rate: 100, property_id: property.id)


     visit root_path

     click_on 'Login'
     fill_in 'Email', with: user.email
     fill_in 'Senha', with: user.password
     click_on 'Entrar'


    visit root_path
    click_on 'Apartamento Top'
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '05/09/2017'
    fill_in 'Data Final', with: '10/09/2017'
    fill_in 'Quantidade de hóspedes', with: '4'
    fill_in 'Nome', with: 'Fernando da Silva'
    fill_in 'Email', with: 'fernado@silva.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11)99899-0909'
    fill_in 'Observações', with: 'Pretendo levar dois cachorros e um gato'

    click_on 'Enviar'

    expect(page).to have_css('li', text: '05/09/2017')
    expect(page).to have_css('li', text: '10/09/2017')
    expect(page).to have_css('li', text: 'Valor total: R$ 500,00')
  end

end
