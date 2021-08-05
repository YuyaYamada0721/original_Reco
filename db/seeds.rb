User.create!(username: 'AdminUser',
             email: 'admin@example.com',
             password: 'password',
             password_confirmation: 'password',
             image: open('./app/assets/images/user0.jpg'),
             introduction: 'どうも。AdminUserです。',
             admin: true)

9.times do |n|
  username = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = 'password'
  image_num = n + 1
  User.create!(
    username: username,
    email: email,
    password: password,
    password_confirmation: password,
    image: open("./app/assets/images/user#{image_num}.jpg"),
    introduction: "どうも。#{username}です。"
  )
end
