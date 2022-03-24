require "application_system_test_case"

# Acceptance Criteria: 
# 1. As a professor, I should be able to remove a student from a team
# 2. As a student, I should not be able to remove anyone from a team

class DeleteStudentFromTeamTest < ApplicationSystemTestCase
  setup do
    Option.create(reports_toggled: true)
    @generated_code = Team.generate_team_code
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.create(team_name: 'Test Team', team_code: @generated_code.to_s, user: @prof)
    @bob = User.create(email: 'bob@uwaterloo.ca', name: 'Bob', lastname: 'Bold', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
    @bob.teams << @team
  end
  
  # (1)
  def test_delete_student_as_prof
    visit root_url 
    # Login as professor
    login 'msmucker@uwaterloo.ca', 'professor'

    click_on "Manage Teams"
    click_on "Test Team"
    click_on "Remove User From Team"
    click_on "Remove User"
    
    assert_equal([], @team.users)
  end
  
  # (2)
  def test_delete_student_as_student
    visit root_url 
    # Login as student
    login 'bob@uwaterloo.ca', 'testpassword'
    visit team_path(@bob.teams.first.id)
    
    # Verify that we are on the team's page
    assert_text "Test Team"
    assert_no_text "Remove user from team"
    
    assert_not_equal([], @team.users)
  end

end