# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

project = Project.create!(title: 'Project X', status: 'To Do', description: 'A new Secret Project')
user = User.create!(first_name: 'Jon', last_name: 'Bovi')
project.users << user
Comment.create!(body: 'Gather all inforamtion needed to proceed', user_id: user.id)
