namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_debates
    make_relationships
    make_performances
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_debates
  50.times do
    content = Faker::Lorem.sentence(1)
    title = Faker::Lorem.sentence(1)
    type_of_debate = Faker::Lorem.sentence(1)
    Debate.create!(content: content, type_of_debate: type_of_debate, title: title)
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_performances
  users = User.all
  debates = Debate.all
  user  = users.first
  debate = debates.last
  debate_bis = debates.first
  full_debates = debates[2..50]
  full_debates.each { |f| debate.participate!(f) }
  full_debates.each { |f| debate_bis.participate!(f) }
 
end