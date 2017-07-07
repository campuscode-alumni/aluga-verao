FactoryGirl.define do
  factory :property do
    city "MyString"
    state "MyString"
    type ""
    description "MyText"
    price "9.99"
    photo "MyString"
    capacity 1
    minimun_rent 1
    maximum_rent 1
    rules "MyText"
    rent_purpose "MyString"
  end
end
