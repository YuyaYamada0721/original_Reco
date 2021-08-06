FactoryBot.define do
  factory :team do
    name { 'テストチーム' }
    is_solo { false }
  end
  factory :team2, class: 'Team' do
    name { 'fugaチーム' }
    is_solo { false }
  end
end
