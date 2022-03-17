require "application_system_test_case"

# 1. As a professor, I should be able to see student's that have not 
#    submitted feedbacks for team summary view
# 2. As a professor, I should be able to see student's that have not 
#    submitted feedbacks for team detailed view

class ListUsersWithoutSubmissionsTest < ApplicationSystemTestCase
  setup do
    # create prof, team, and user
    @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    user1 = User.create(email: 'charles2@gmail.com', password: 'banana', password_confirmation: 'banana', name: 'Charles1', lastname: 'Chocolate1', is_admin: false)
    user1.save!
    user2 = User.create(email: 'charles3@gmail.com', password: 'banana', password_confirmation: 'banana', name: 'Charles2', lastname: 'Chocolate2', is_admin: false)
    user2.save!
    user3 = User.create(email: 'charles4@gmail.com', password: 'banana', password_confirmation: 'banana', name: 'Charles3', lastname: 'Chocolate3', is_admin: false)
    team = Team.new(team_code: 'Code', team_name: 'Team Cst')
    team.users = [user1, user2, user3]
    team.user = @prof 
    team.save!     
    
    feedback = save_feedback(10, "This team is disorganized", user1, DateTime.civil_from_format(:local, 2021, 3, 1), team, 2, "progress_comments", 2,2,2,2,2,2,2,2,2)
    feedback2 = save_feedback(5, "This team is disorganized", user2, DateTime.civil_from_format(:local, 2021, 3, 3), team, 2, "progress_comments", 2,2,2,2,2,2,2,2,2)
  end
  
  # (1)
  def test_not_submitted_feedback_summary_view 
    visit root_url 
    login 'msmucker@gmail.com', 'professor'
    assert_current_path root_url 
    
    assert_text "Missing Feedback"
    assert_in_delta(1, 1)
  end 
  
  # (2)
  def test_not_submitted_feedback_detailed_view 
    visit root_url 
    login 'msmucker@gmail.com', 'professor'
    assert_current_path root_url 
    click_on "Manage Teams"
    assert_current_path root_url 
    click_on "Team Cst"
    
    assert_text "No feedbacks yet!"
  end 
end
