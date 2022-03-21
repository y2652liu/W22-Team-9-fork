# *acceptance criteria* : 
# 1. As an instructor, I am able to see the history of feedback per user, including comment, rating, timestamp, and priority. 

require "application_system_test_case"

class DisplayUserHistoryTest < ApplicationSystemTestCase
# I modeled this test class off of create_summary_page_view_of_teams_test.rb (mostly) created by the earlier team
    setup do
        # create prof, team, and user
        @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
        
        @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
        
        @cici = User.create(email: 'cici@gmail.com', name: 'Cici', lastname: 'Kiki', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
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
        login 'msmucker@gmail.com', 'professor'
        click_on "Manage Users"
        assert_current_path users_url
 
      within('#user' + @cici.id.to_s) do
        click_on 'Cici'
      end

      assert_text "9"
      assert_text "Urgent"
      assert_text datetime.strftime("%Y-%m-%d %H:%M")
      assert_text "This team is disorganized"
      end
      
  end



    
