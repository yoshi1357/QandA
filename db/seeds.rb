# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Faker::Config.locale = :ja

# Userのデータを生成
# 100.times do |n|
#   name = Faker::Name.name
#   email = Faker::Internet.email
#   password = "Password123"

#   User.create!(name: name,
#               email: email,
#               password: password,
#               password_confirmation: password,
#               )
# end


# Questionのデータを生成
# 100.times do |n|
#   title = Faker::Lorem.sentence(word_count: 10)
#   content = Faker::Lorem.sentence(word_count: 30)
#   user_id = Faker::Number.between(from: 1,to: User.count)

#   Question.create!(title: title,
#                   content: content,
#                   user_id: user_id
#   )
# end

# Answerのデータを生成
100.times do |n|
  id = Faker::Number.between(from: 1,to: Question.count)
  question = Question.find(id)
  content = Faker::Lorem.sentence(word_count: 30)
  user_id = Faker::Number.between(from: 1,to: User.count)

  Answer.create!(question: question,
                content: content,
                user_id: user_id

  )
end



# Questionにuser_idを設定
# 100.times do |n|
#   user_id = Faker::Number.between(from: 1,to: User.count)
#   question = Question.find(n + 1)

#   question.user_id = user_id
#   question.save
# end


# Answerにuser_idを設定
# 100.times do |n|
#   user_id = Faker::Number.between(from: 1,to: User.count)
#   # nは0から始まるためn+1
#   answer = Answer.find(n + 1)

#   answer.user_id = user_id
#   answer.save
# end