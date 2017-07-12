require 'rails_helper'

  feature 'Owner configure price_range by period' do
    scenario 'successfully' do

      property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type: 'Apartamento',
                                description: 'Apartamento grande na região do Paraisópolis',
                                daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                                rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

      visit root_path
      click_on 'Apartamento Top'
      click_on 'Cadastrar valor por periodo'

      fill_in 'Data Inicial', with: '05/12/2017'
      fill_in 'Data Final', with: '05/01/2018'
      fill_in 'Valor da diaria', with: '150,00'

      click_on 'Enviar'

      expect(page).to have_css('h2', text: 'Preço cadastrado com sucesso')
      expect(page).to have_css('li', text: '05/12/2017')
      expect(page).to have_css('li', text: '05/01/2018')
      expect(page).to have_css('li', text: 'R$ 150,00')
    end

    scenario 'and missing some attribute' do

      property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type: 'Apartamento',
                                description: 'Apartamento grande na região do Paraisópolis',
                                daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                                rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

      visit root_path
      click_on 'Apartamento Top'
      click_on 'Cadastrar valor por periodo'

      fill_in 'Data Inicial', with: ''
      fill_in 'Data Final', with: ''
      fill_in 'Valor da diaria', with: ''

      click_on 'Enviar'

      expect(page).to have_css('h3', text: 'Houve um erro ao tentar cadastrar o preço por periodo')
    end

    scenario 'and start_date < today' do
      property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type: 'Apartamento',
                                description: 'Apartamento grande na região do Paraisópolis',
                                daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                                rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

    visit root_path
    click_on 'Apartamento Top'
    click_on 'Cadastrar valor por periodo'

    fill_in 'Data Inicial', with: Date.today - 1
    fill_in 'Data Final', with: Date.today + 20
    fill_in 'Valor da diaria', with: '150,00'

    click_on 'Enviar'

    expect(page).to have_css('h3', text: 'Data inicial deve ser maior ou igual a data de hoje')
    end

    scenario 'and start_date < today' do
      property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type: 'Apartamento',
                                description: 'Apartamento grande na região do Paraisópolis',
                                daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                                rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

      visit root_path
      click_on 'Apartamento Top'
      click_on 'Cadastrar valor por periodo'

      fill_in 'Data Inicial', with: Date.today
      fill_in 'Data Final', with: Date.today - 20
      fill_in 'Valor da diaria', with: '150,00'

      click_on 'Enviar'

      expect(page).to have_css('h3', text: 'Data final deve ser maior do que a data inicial')
    end

    scenario 'and period strikes another period' do
      property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type: 'Apartamento',
                                description: 'Apartamento grande na região do Paraisópolis',
                                daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                                rules: 'Não pode faltar o pancadão e tem que fumar o colchão', rent_purpose: 'Pancadão', owner: 'vo Carlos')

      visit root_path
      click_on 'Apartamento Top'
      click_on 'Cadastrar valor por periodo'

      fill_in 'Data Inicial', with: Date.today
      fill_in 'Data Final', with: Date.today + 40
      fill_in 'Valor da diaria', with: '150,00'

      click_on 'Enviar'

      visit root_path
      click_on 'Apartamento Top'
      click_on 'Cadastrar valor por periodo'

      fill_in 'Data Inicial', with: Date.today + 30
      fill_in 'Data Final', with: Date.today + 70
      fill_in 'Valor da diaria', with: '150,00'

      click_on 'Enviar'

      expect(page).to have_css('h3', text: 'Já existe um preço personalizado para esse periodo')
    end

  end
