require "application_system_test_case"

# Acceptance Criteria:
# 1. As a student when submitting feedback before deadline but others hasn't submit yet, I should not see the average display on my dashboard.

class EmptyTeamZeroMissingFeedback < ApplicationSystemTestCase
    setup do
     @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
      @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
    end 
      
    def test_student_dashboard_not_all_submit
      visit root_url
      login 'msmucker@uwaterloo.ca', 'professor'
      assert_current_path root_url
    
      assert_no_text "0"
    end

end