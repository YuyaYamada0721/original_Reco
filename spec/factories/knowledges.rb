FactoryBot.define do
  factory :knowledge do
    name { 'テストナレッジ' }
  end
  factory :knowledge2, class: 'Knowledge' do
    name { 'fugaナレッジ' }
  end
end
