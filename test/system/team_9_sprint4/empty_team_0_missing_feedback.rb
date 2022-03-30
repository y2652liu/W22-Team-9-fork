require "application_system_test_case"

# Acceptance Criteria:
# 1. Should display a 0 under missing feedback for an empty team.

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