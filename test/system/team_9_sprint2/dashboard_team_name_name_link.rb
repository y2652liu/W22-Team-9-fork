# Acceptance Criteria: 
# 1. As an instructor, on dashboard, details link is no longer there; team name links to team's /show


require "application_system_test_case"

class ShowTeamNameLink < ApplicationSystemTestCase
# I modeled this test class off of manage_users_show_name_link.rb (created by team member)

    setup do
        # create prof, team, and user
        @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
        
        @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
        
        @charles = User.create(email: 'bob@uwaterloo.ca', name: 'Charles', lastname: 'Chaplin', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
        @charles.teams << @team
        
    end

    def test_team_name_link
        visit root_url 
        login 'msmucker@uwaterloo.ca', 'professor'
 
        within('#' + @team.id.to_s) do 
        click_on 'Test Team'
      end
      assert_current_path team_url(@team)

      end
      
  end



    
