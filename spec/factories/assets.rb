# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset do
    project nil
    title "MyString"
    notes "MyText"
  end
end
