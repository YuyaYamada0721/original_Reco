FactoryBot.define do
  factory :tag do
    name { 'テストタグ' }
  end
  factory :tag2, class: 'Tag' do
    name { 'ファクトリー' }
  end
end
