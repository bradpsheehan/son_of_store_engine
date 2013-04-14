# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :billing do
    street "MyString"
    city "MyString"
    state "MyString"
    zipcode "MyString"
    user nil
    order nil
  end
end
