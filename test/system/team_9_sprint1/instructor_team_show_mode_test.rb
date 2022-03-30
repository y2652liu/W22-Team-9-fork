
# Acceptance Criteria: 
# 1. As an instructor, correctly display mode as an insight

require "application_system_test_case"

#class InstructorTeamShowModeTest < ApplicationSystemTestCase
  # I modeled this test class off of instructor_team_show_average_test.rb
  # created by group member
  #setup do
    
    #@prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    #@team = Team.new(team_code: 'Code', team_name: 'Team 1', id: 1)
    #@team.user = @prof 
    #@team.save!
    
    #@user1 = User.create(email: 'test@uwaterloo.ca', name: 'Test User', is_admin: false, password: 'Security!', password_confirmation: 'Security!', teams: [@team])
    #@user1.save

    #@user2 = User.create(email: 'test2@uwaterloo.ca', name: 'Test User', is_admin: false, password: 'Security!', password_confirmation: 'Security!', teams: [@team])
    #@user2.save
    
    #@user3 = User.create(email: 'test3@uwaterloo.ca', name: 'Test User', is_admin: false, password: 'Security!', password_confirmation: 'Security!', teams: [@team])
    #@user3.save

    #@user4 = User.create(email: 'test4@uwaterloo.ca', name: 'Test User', is_admin: false, password: 'Security!', password_confirmation: 'Security!', teams: [@team])
    #@user3.save

# <<<<<<< HEAD
#     @feedback = save_feedback(10, "This team is disorganized", @user1, Time.zone.now.to_datetime - 30, @team, 2, "progress_comments", 2,2,2,2,2,2,2,2,2) 
#     @feedback = save_feedback(4, "This team is disorganized", @user2, Time.zone.now.to_datetime - 30, @team, 2, "progress_comments", 2,2,2,2,2,2,2,2,2)
#     @feedback = save_feedback(7, "This team is disorganized", @user3, Time.zone.now.to_datetime - 30, @team, 2, "progress_comments", 2,2,2,2,2,2,2,2,2) 
#     @feedback = save_feedback(4, "This team is disorganized", @user3, Time.zone.now.to_datetime - 30, @team, 2, "progress_comments", 2,2,2,2,2,2,2,2,2) 
# =======
#     #@feedback = save_feedback(10, "This team is disorganized", @user1, Time.zone.now.to_datetime - 30, @team, 2) 
#     #@feedback = save_feedback(4, "This team is disorganized", @user2, Time.zone.now.to_datetime - 30, @team, 2)
#     #@feedback = save_feedback(7, "This team is disorganized", @user3, Time.zone.now.to_datetime - 30, @team, 2) 
#     #@feedback = save_feedback(4, "This team is disorganized", @user3, Time.zone.now.to_datetime - 30, @team, 2) 
# >>>>>>> fix broken capybara tests
     
#     #visit root_url
#     #login 'msmucker@uwaterloo.ca', 'professor'
#   #end

#   #def test_median_is_shown
#     #visit 'teams/1'
#     #assert_text "Mode: 4" 
#   #end

# #end
