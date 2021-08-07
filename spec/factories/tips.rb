FactoryBot.define do
  factory :tip do
    name { 'テストティップ' }
    content { '機能テストです。確認お疲れ様です。' }
  end
  factory :tip2, class: 'Tip' do
    name { 'fugaティップ' }
    content { 'fugaティップです。安全確認よし' }
  end
end
