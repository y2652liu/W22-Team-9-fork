require "application_system_test_case"

# Acceptance Criteria:
# 1. Multiple students with the same email cannot be added to a team

#Test modeled off a test created by previous team

class DuplicateStudentsTest < ApplicationSystemTestCase
  def setup
    Option.create(reports_toggled: true)
    prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: prof)
    user = User.create(email: 'scottf@uwaterloo.ca', password: 'banana', password_confirmation: 'banana', name: 'Scott', lastname: 'F', is_admin: false, teams: [team])
  end
 
  def test_create_duplicate_user_email_sad_path
    # register new student
    visit root_url
    click_on "Sign Up"

    fill_in "user[name]", with: "Scott"
    fill_in "user[lastname]", with: "F"
    fill_in "user[team_code]", with: "TEAM01"
    fill_in "user[email]", with: "scottf@uwaterloo.ca"
    fill_in "user[password]", with: "appl123"
    fill_in "user[password_confirmation]", with: "apple123"
    click_on "Create account"
  assert_text "has already been taken"
  end
  def test_create_duplicate_user_email_happy_path
    # register new student
    visit root_url
    click_on "Sign Up"

    fill_in "user[name]", with: "Ahmed"
    fill_in "user[lastname]", with: "I"
    fill_in "user[team_code]", with: "TEAM01"
    fill_in "user[email]", with: "ahmed@uwaterloo.ca"
    fill_in "user[password]", with: "apple123"
    fill_in "user[password_confirmation]", with: "apple123"
    click_on "Create account"
  assert_current_path root_url
      assert_text "Welcome, Ahmed"
  end
end
 