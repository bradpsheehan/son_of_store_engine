# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shipping do
    user nil
    order nil
    street "MyString"
    city "MyString"
    state "MyString"
    zipcode "MyString"
  end
end
