# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Faker::Config.locale = :ja

# 100.times do |n|
#   name = Faker::Name.name
#   title = Faker::Lorem.sentence(word_count: 10)
#   content = Faker::Lorem.sentence(word_count: 30)

#   Question.create!(name: name,
#                   title: title,
#                   content: content,
#   )

# end

100.times do |n|
  id = Faker::Number.between(from: 1,to: Question.count)
  question = Question.find(id)
  name = Faker::Name.name
  content = Faker::Lorem.sentence(word_count: 30)

  Answer.create!(name: name,
                question: question,
                content: content,
  )

end