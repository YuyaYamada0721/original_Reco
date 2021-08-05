# ---------User
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
# ----------

# ----------Team
2.times do |n|
  user_id = 1
  owner_id = 1
  name = '製造部'
  team_num = n + 1
  Team.create!(
    user_id: user_id,
    owner_id: owner_id,
    name: "#{name}#{team_num}班"
  )
end

Team.create!(
  user_id: 1,
  owner_id: 1,
  name: '学習記録',
  is_solo: 'true'
)

2.times do |n|
  user_id = 2
  owner_id = 2
  name = '情報管理'
  team_num = n + 1
  Team.create!(
    user_id: user_id,
    owner_id: owner_id,
    name: "#{name}#{team_num}班"
  )
end
# ----------Team

# ----------Member
Member.create!(
  [
    { user_id: 1, team_id: 1 },
    { user_id: 3, team_id: 1 },
    { user_id: 4, team_id: 1 },
    { user_id: 1, team_id: 2 },
    { user_id: 5, team_id: 2 },
    { user_id: 6, team_id: 2 },
    { user_id: 1, team_id: 3 },
    { user_id: 2, team_id: 4 },
    { user_id: 7, team_id: 4 },
    { user_id: 8, team_id: 4 },
    { user_id: 2, team_id: 5 },
    { user_id: 9, team_id: 5 }
  ]
)
