FactoryBot.define do
  factory :user do
    username { 'piyo' }
    email { 'piyo@piyo.com' }
    password { 'piyopiyo' }
    password_confirmation { 'piyopiyo' }
    admin { 'true' }
  end
end
