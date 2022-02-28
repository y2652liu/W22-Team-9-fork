
# Acceptance Criteria: 
# 1. As an instructor, on manage users, show link is no longer there; name column links to user's /show

require "application_system_test_case"

class ShowNameLink < ApplicationSystemTestCase
# I modeled this test class off of DisplayFeedbackHistoryUser.rb (mostly) created in Sprint 1

    setup do
        # create prof, team, and user
        @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
        
        @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
        
        @bob = User.create(email: 'bob@gmail.com', name: 'Bob', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
        @bob.teams << @team
        
    end

    def test_user_name_link_show
        visit root_url 
        login 'msmucker@gmail.com', 'professor'
        click_on "Manage Users"
        assert_current_path users_url
 
      within('#user' + @bob.id.to_s) do
        click_on 'Bob'
        assert_current_path user_url(@bob)
      end

      end
      
  end



    
