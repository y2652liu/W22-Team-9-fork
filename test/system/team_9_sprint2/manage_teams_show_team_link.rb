
# Acceptance Criteria: 
# 1. As an instructor, on manage teams, show link is no longer there; team name column links to team's /show

require "application_system_test_case"

class ShowTeamLink < ApplicationSystemTestCase
# I modeled this test class off of DisplayFeedbackHistoryUser.rb (mostly) created in Sprint 1

    setup do
        # create prof, team, and user
        @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
        
        @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
        
        @mike = User.create(email: 'bob@gmail.com', name: 'Mike', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
        @mike.teams << @team
        
    end

    def test_team_name_link_show
        visit root_url 
        login 'msmucker@gmail.com', 'professor'
        click_on "Manage Teams"
        assert_current_path teams_url
 
      within('#team' + @team.id.to_s) do 
        click_on 'Test Team'
      end
      assert_current_path team_url(@team)

      end
      
  end



    
