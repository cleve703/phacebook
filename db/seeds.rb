# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

20.times do
  continue = true
  while continue == true
    name = Faker::Name.unique.name
    continue = false if !name.include?(".") && !name.include?("Mr") && !name.include?("Miss") && name.include?(" ")
  end
  email = name.split(" ")[0] + "." + name.split(" ")[1] + "@email.com"
  User.create(name: name, email: email, password: 'password')
end