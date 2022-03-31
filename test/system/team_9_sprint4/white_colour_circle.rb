require "application_system_test_case"
require 'date'

# Acceptance Criteria:
# 1. Coloured circle should be white if there are no members on a team.
# 2. When the priority is not displayed the priority circle is coloured white

class WhiteColourCircle < ApplicationSystemTestCase

  #Happy path test of empty team
  def created_empty_team
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    assert find('.dot-beige')
  end 


  #Sad path of no one having submitted
  def test_no_feedbacks

    @user1 = User.new(email: 'test1@uwaterloo.ca', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac1', lastname: 'Efron', is_admin: false)
    @user2 = User.new(email: 'test2@uwaterloo.ca', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac2', lastname: 'Efron', is_admin: false)
    @user3 = User.new(email: 'test3@uwaterloo.ca', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac3', lastname: 'Efron', is_admin: false)
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
    @user1.teams << @team
    @user2.teams << @team
    @user3.teams << @team
    @user1.save
    @user2.save
    @user3.save

    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    assert_text 'Test Team'
    assert_text 'No feedback'
    assert find('.dot-beige')

  end

  #Test of the student's view
  def test_student_no_feedback
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.new(team_code: 'Code', team_name: 'Team 1')
    @team.user = @prof 
    @team.save!
    @user = User.create(email: 'bob@uwaterloo.ca', name: 'Bob', lastname: 'Kosner', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
    @user.teams << @team
    @user.save
    visit root_url
    login 'bob@uwaterloo.ca', 'testpassword'
    assert_text 'Team 1'
    assert_text 'No feedback'
    assert find('.dot-beige')
  end
  
end

