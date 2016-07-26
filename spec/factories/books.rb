FactoryGirl.define do
  factory :book do
    title "MyString"
    isbn "MyString"
    cover "MyString"
    association :publisher
  end
end
