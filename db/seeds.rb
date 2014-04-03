# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(	name:   "Administrator",
               	email:  "munro_mates_admin@gmail.com",
               	password: "foobar",
               	password_confirmation: "foobar",
               	admin: true)

User.create!(	name:   "Jim Hunter",
               	email:  "j.hunter@abdn.ac.uk",
               	password: "10Lanthe",
               	password_confirmation: "10Lanthe")
