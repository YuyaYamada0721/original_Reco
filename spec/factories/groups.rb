FactoryBot.define do
  factory :group do
    is_dm { false }
  end
  factory :group2, class: 'Group' do
    is_dm { false }
  end
end
