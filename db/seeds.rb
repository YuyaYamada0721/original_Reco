# ---------User
User.create!(username: 'AdminUser',
             email: 'admin@example.com',
             password: 'password',
             password_confirmation: 'password',
             image: open('./app/assets/images/user0.jpg'),
             introduction: 'どうも。AdminUserです。',
             admin: true)

9.times do |n|
  username = Faker::Name.name
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
# ----------Member

# ----------Group
Group.create!(
  [
    { is_dm: false },
    { is_dm: false },
    { is_dm: false },
    { is_dm: false },
    { is_dm: false },
    { is_dm: true }
  ]
)
# ----------Group

# ----------GroupMember
GroupMember.create!(
  [
    { member_id: 1, group_id: 1 },
    { member_id: 2, group_id: 1 },
    { member_id: 3, group_id: 1 },
    { member_id: 4, group_id: 2 },
    { member_id: 5, group_id: 2 },
    { member_id: 6, group_id: 2 },
    { member_id: 7, group_id: 3 },
    { member_id: 8, group_id: 4 },
    { member_id: 9, group_id: 4 },
    { member_id: 10, group_id: 4 },
    { member_id: 11, group_id: 5 },
    { member_id: 12, group_id: 5 },
    { member_id: 1, group_id: 6 },
    { member_id: 2, group_id: 6 }
  ]
)
# ----------GroupMember

# ----------Message
Message.create!(
  [
    { member_id: 1, group_id: 1, body: 'はじめまして' },
    { member_id: 2, group_id: 1, body: 'よろしくおねがします' },
    { member_id: 3, group_id: 1, body: 'よろです' },
    { member_id: 1, group_id: 1, body: '今月中に学習した事をまとめて下さい' },
    { member_id: 2, group_id: 1, body: '了解しました' },
    { member_id: 3, group_id: 1, body: '・・・' }
  ]
)
# ----------Message

# ----------Read
Read.create!(
  [
    { member_id: 2, message_id: 1, is_checked: true },
    { member_id: 3, message_id: 1, is_checked: true },
    { member_id: 1, message_id: 2, is_checked: true },
    { member_id: 3, message_id: 2, is_checked: true },
    { member_id: 1, message_id: 3, is_checked: true },
    { member_id: 2, message_id: 3, is_checked: true },
    { member_id: 2, message_id: 4, is_checked: true },
    { member_id: 3, message_id: 4, is_checked: true },
    { member_id: 1, message_id: 5, is_checked: true },
    { member_id: 3, message_id: 5, is_checked: true },
    { member_id: 1, message_id: 6, is_checked: true },
    { member_id: 2, message_id: 6, is_checked: true }
  ]
)
# ----------Read

# ----------Knowledge
Knowledge.create!(
  [
    { member_id: 1, team_id: 1, name: 'ライン毎の製品まとめ' },
    { member_id: 2, team_id: 1, name: '段取りまとめ' },
    { member_id: 7, team_id: 3, name: 'Ruby初級' },
    { member_id: 8, team_id: 4, name: 'パソコン管理' },
    { member_id: 8, team_id: 4, name: '消耗品注文' }
  ]
)
# ----------Knowledge

# ----------Stock
Stock.create!(
  [
    { member_id: 1, knowledge_id: 1 },
    { member_id: 2, knowledge_id: 1 },
    { member_id: 3, knowledge_id: 1 },
    { member_id: 1, knowledge_id: 2 },
    { member_id: 2, knowledge_id: 2 },
    { member_id: 3, knowledge_id: 2 },
    { member_id: 8, knowledge_id: 4 },
    { member_id: 9, knowledge_id: 4 },
    { member_id: 10, knowledge_id: 4 }
  ]
)
# ----------Stock

# ----------Tip
Tip.create!(
  [
    { member_id: 1, knowledge_id: 1, team_id: 1, name: 'Fライン', content: '製品A、製品B、製品C' },
    { member_id: 1, knowledge_id: 1, team_id: 1, name: 'Gライン', content: '製品D、製品E、製品F' },
    { member_id: 2, knowledge_id: 1, team_id: 1, name: 'Hライン', content: '製品G、製品H、製品I' },
    { member_id: 1, knowledge_id: 2, team_id: 1, name: '機械Ⅰ段取り手順', content: '①カバーを外します・・・' },
    { member_id: 2, knowledge_id: 2, team_id: 1, name: '機械Ⅱ段取り手順', content: '①カバーを外して、内部清掃・・・' },
    { member_id: 7, knowledge_id: 3, team_id: 3, name: '配列', content: 'Rubyにおいて配列を作成する場合は括弧（ [] ）を使用します' },
    { member_id: 8, knowledge_id: 4, team_id: 4, name: 'デスクトップ', content: '富士通：１０台、LENOVO：５台' },
    { member_id: 9, knowledge_id: 5, team_id: 4, name: 'プリンター', content: 'トナー、ドラムユニット' }
  ]
)
# ----------Tip

# ----------Picture
Picture.create!(
  [
    { tip_id: 1, image: open('./app/assets/images/screw0.jpg') },
    { tip_id: 1, image: open('./app/assets/images/screw1.jpg') },
    { tip_id: 1, image: open('./app/assets/images/drone.jpg') },
    { tip_id: 7, image: open('./app/assets/images/computer.png') },
    { tip_id: 8, image: open('./app/assets/images/printer.png') }
  ]
)
# ----------Picture

# ----------Tag
Tag.create!(
  [
    { team_id: 1, name: '確認要' },
    { team_id: 1, name: '重要' },
    { team_id: 3, name: 'RubyonRails' },
    { team_id: 4, name: '基礎' },
    { team_id: 4, name: 'よくある問い合わせ' }
  ]
)
# ----------Tag

# ----------Tagging
Tagging.create!(
  [
    { tip_id: 1, tag_id: 1 },
    { tip_id: 2, tag_id: 2 },
    { tip_id: 6, tag_id: 3 },
    { tip_id: 7, tag_id: 4 },
    { tip_id: 8, tag_id: 5 }
  ]
)
# ----------Tagging
