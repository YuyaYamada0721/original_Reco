FactoryBot.define do
  factory :team do
    user { nil }
    owner_id { 1 }
    name { "MyString" }
    is_solo { false }
  end
end
