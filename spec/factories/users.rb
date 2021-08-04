FactoryBot.define do
  factory :user do
    username { 'piyo' }
    email { 'piyo@piyo.com' }
    password { 'piyopiyo' }
    password_confirmation { 'piyopiyo' }
    admin { 'true' }
  end
  factory :user2, class: 'User' do
    username { 'fuga' }
    email { 'fuga@fuga.com' }
    password { 'fugafuga' }
    password_confirmation { 'fugafuga' }
    admin { 'false' }
  end
end
