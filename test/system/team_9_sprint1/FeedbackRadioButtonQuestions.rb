require "application_system_test_case"

class RadioButtonsTest < ApplicationSystemTestCase
# This test class was modeled based on create_summary_page_view_of_teams_test.rb created by the earlier team
    setup do
        # create prof, team, and user
        @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
        
        @team = Team.create(team_name: 'TestTeam2', team_code: 'TEAM02', user: @prof)
        
        @michael = User.create(email: 'michael@gmail.com', name: 'Michael', is_admin: false, password: 'tester2', password_confirmation: 'tester2')
        @michael.teams << @team 
    end

    def test_view_user_priority
        feedback = Feedback.new(rating: 5, priority: 1, comments: "This is a test comment", goal_rating: 3, communication_rating: 4, positive_rating: 2, reach_rating: 1, bounce_rating: 5, account_rating: 3, decision_rating: 2, respect_rating: 4, progress_comments: "This is test progress comments")
        datetime = Time.current
        feedback.timestamp = feedback.format_time(datetime)
        feedback.user = @michael
        feedback.team = @michael.teams.first
        feedback.save

        assert feedback.valid?
    end
      
  end