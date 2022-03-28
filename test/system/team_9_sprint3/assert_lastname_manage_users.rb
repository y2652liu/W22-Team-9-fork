# *Acceptance Criteria* : 
# 1. On the 'Manage Users' page there are 2 columns for name.

require "application_system_test_case"

class DisplaySecondNameColumnTest < ApplicationSystemTestCase
# I modeled this test class off of create_summary_page_view_of_teams_test.rb (mostly) created by the earlier team
    setup do
        # create prof, team, and user
        @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
        
        @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
        
        @cici = User.create(email: 'cici@uwaterloo.ca', name: 'Cici', lastname: 'Awesome', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
        @cici.teams << @team
        
    end

    def test_view_user_priority
        feedback = Feedback.new(rating: 9, priority: 0, comments: "This team is disorganized")
        datetime = Time.current
        feedback.timestamp = feedback.format_time(datetime)
        feedback.user = @cici
        feedback.team = @cici.teams.first
        feedback.save
        
        visit root_url 
        login 'msmucker@uwaterloo.ca', 'professor'
        click_on "Manage Users"
        assert_current_path users_url
        assert_text "Last Name"
        
      within('#user' + @cici.id.to_s) do
      assert_text "Awesome"
      end
    end
 
  end



    
