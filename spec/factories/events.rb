# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    address "MyString"
    ended_at "2014-03-28 14:46:48"
    lat "9.99"
    lng "9.99"
    name "MyString"
    started_at "2014-03-28 14:46:48"

    association :owner, factory: :user
  end
end
