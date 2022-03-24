require "application_system_test_case"

class SignInUppercasesTest < ApplicationSystemTestCase
  setup do
    Option.create(reports_toggled: true)
    @generated_code = Team.generate_team_code
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.create(team_name: 'Test Team', team_code: @generated_code.to_s, user: @prof)
    @bob = User.create(email: 'bob@uwaterloo.ca', name: 'Bob', lastname: 'Bold', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
    @bob.teams << @team
  end
    
  def test_sign_in_regular
    visit root_url 
    # Login as student
    login 'bob@uwaterloo.ca', 'testpassword'

    assert_text "Welcome, Bob"
    
  end
    
  def test_sign_in_uppercase
    visit root_url 
    # Login as student
    login 'BOB@uwaterloo.ca', 'testpassword'

    assert_text "Welcome, Bob"
    
  end
end
