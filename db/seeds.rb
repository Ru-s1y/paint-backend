# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 3.times do |n|
#   User.create!(
#     name: "testUser#{n+1}",
#     email: "test#{n+1}@example.com",
#     password: "password",
#     password_confirmation: "password"
#   )
# end

3.times do |x|
  Room.create!(
    name: "room#{x+1}",
    description: "unpublish",
    publish: "false",
    password: "password",
    password_confirmation: "password",
    user_id: "#{x+1}"
  )
end

3.times do |m|
  Message.create!(
    user_id: "#{m+1}",
    room_id: "#{m+1}",
    message: "Hello, testUser_#{m+1}"
  )
end