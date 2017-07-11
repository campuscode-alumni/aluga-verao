FactoryGirl.define do
  factory :proposal do
    start_date "2017-07-07"
    end_date "2017-07-07"
    total_amount "9.99"
    total_guests 1
    name "MyString"
    email "MyString"
    cpf "MyString"
    phone "MyString"
    observation "MyText"
    property nil
  end
end
