require "application_system_test_case"

class HelpMenuBarStudentsTest < ApplicationSystemTestCase
  # I modeled this test class off of help_pages_test created
  # by the earlier team
  setup do
    @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.new(team_code: 'Code', team_name: 'Team 1')
    @team.user = @prof 
    @team.save!
    
    @user = User.create(email: 'test@gmail.com', name: 'Test User', is_admin: false, password: 'Security!', password_confirmation: 'Security!', teams: [@team])
    @user.save
    visit root_url
    login 'test@gmail.com', 'Security!'
  end

  def test_home_to_help
    click_on 'Help'
    assert_current_path '/team_view/help'
  end

  def test_feedback_to_help    
    click_link 'Submit for: Team 1'
    click_on 'Help'
    assert_current_path '/team_view/help'
  end

  def test_change_password_to_help    
    click_on 'Change Password'
    click_on 'Help'
    assert_current_path '/team_view/help'
  end
end
