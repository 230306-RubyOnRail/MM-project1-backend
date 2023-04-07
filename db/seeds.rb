# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
man = Role.find_by(name: 'manager')
emp = Role.find_by(name: 'employee')

User.create(name: 'John Manager', email: 'da_boss@localhost.com', password: 'bds_man', role: man)
User.create(name: 'Karl Peasant', email: 'karl@localhost.com', password: 'mypassword', role: emp)
