FactoryBot.define do
  factory :group_member do
    member { "" }
    group { "" }
  end
  factory :group_member2, class: 'GroupMember' do
    member { "" }
    group { "" }
  end
end
