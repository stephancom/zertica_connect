# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_file do
    project nil
    url "MyString"
    data ""
  end
end
