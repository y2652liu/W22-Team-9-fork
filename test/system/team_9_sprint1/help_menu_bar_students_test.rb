# *acceptance criteria* : 
# 1. As a student, I am able to access the help tab from dashboard, feedback page, and change password page.

require "application_system_test_case"

class HelpMenuBarStudentsTest < ApplicationSystemTestCase
  # I modeled this test class off of help_pages_test created
  # by the earlier team
  setup do
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.new(team_code: 'Code', team_name: 'Team 1')
    @team.user = @prof 
    @team.save!
    
    @user = User.create(email: 'bob@uwaterloo.ca', name: 'Bob', lastname: 'Kosner', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
    @user.teams << @team
    @user.save
    visit root_url
    login 'bob@uwaterloo.ca', 'testpassword'
  end

  def test_home_to_help
    click_on "Help"
    assert_current_path '/team_view/help'
  end

  def test_feedback_to_help    
    click_on "Submit for"
    click_on "Help"
    assert_current_path '/team_view/help'
  end

  def test_change_password_to_help    
    click_on "Change Password"
    click_on "Help"
    assert_current_path '/team_view/help'
  end


end
