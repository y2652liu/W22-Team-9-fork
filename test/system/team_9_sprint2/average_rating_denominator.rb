class AverageratingDenominatorTest < ApplicationSystemTestCase
    # This test class was modeled based on create_summary_page_view_of_teams_test.rb created by the earlier team
        setup do
            # create prof, team, and user
            @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
            
            @team = Team.create(team_name: 'TestTeam', team_code: 'TEAM', user: @prof)
            
            @cici1 = User.create(email: 'cici1@gmail.com', name: 'cici1', is_admin: false, password: ',,,,,,', password_confirmation: ',,,,,,')
            @cici2 = User.create(email: 'cici2@gmail.com', name: 'cici2', is_admin: false, password: ',,,,,,', password_confirmation: ',,,,,,')
            @cici3 = User.create(email: 'cici2@gmail.com', name: 'cici2', is_admin: false, password: ',,,,,,', password_confirmation: ',,,,,,')
            
            @cici1.teams << @team 
            @cici2.teams << @team 
            @cici3.teams << @team 
        end
    
        def test_average_dashboard
            feedback1 = Feedback.new(rating: 5, priority: 1, comments: "This is a test comment", goal_rating: 3, communication_rating: 4, positive_rating: 2, reach_rating: 1, bounce_rating: 5, account_rating: 3, decision_rating: 2, respect_rating: 4, progress_comments: "yeyeye1")
            datetime = Time.current
            feedback.timestamp = feedback.format_time(datetime)
            feedback.user = @cici1
            feedback.team = @cici1.teams.first
            feedback.save
    
            visit root_url 
            login 'msmucker@gmail.com', 'professor'
            
            
            assert feedback.valid?
        end
          
      end