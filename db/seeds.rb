# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

option = Option.create(reports_toggled: false)
option.generate_admin_code(6)

email = 'msmucker@uwaterloo.ca'
name = 'Mark'
lastname = 'Smucker'
password = 'professor'

prof = User.create(email: email, name: name, lastname: lastname, is_admin: true, password: password, password_confirmation: password)


team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: prof)

# feedback = Feedback.create(rating: 10, comments: "This team is disorganized", user_id: user.id, timestamp: Time.zone.now.to_datetime - 30, team_id: team.id) 