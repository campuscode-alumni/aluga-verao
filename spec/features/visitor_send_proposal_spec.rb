require 'rails_helper'

feature 'visitor_send_proposal' do
  scenario 'successfully' do
    #cria os dados necessarios
    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type: 'Apartamento',
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão')

    #proposal = Proposal.create(start_date: Date.new(2017, 5, 12), end_date: Date.new(2017, 5,17),
    #                            total_amount: 200.00, total_guests: 4, name: 'Fernando da Silva',
    #                            email: 'fernando@silva.com', cpf: '12345678901', phone: '45810809',
    #                            observation: 'Pretendo levar dois cachorros')

    visit root_path
    click_on 'Apartamento Top'
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '2017/05/05'
    fill_in 'Data Final', with: '2017/05/10'
    fill_in 'Quantidade de hóspedes', with: '4'
    fill_in 'Nome', with: 'Fernando da Silva'
    fill_in 'Email', with: 'fernado@silva.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11)99899-0909'
    fill_in 'Observações', with: 'Pretendo levar dois cachorros e um gato'

    click_on 'Enviar'

    expect(page).to have_css('h2', text: 'Proposta enviada com sucesso')
  end

end
