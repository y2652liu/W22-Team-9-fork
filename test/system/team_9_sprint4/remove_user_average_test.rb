require "application_system_test_case"

# Acceptance Criteria:
# Infinity should no longer be shown

class RemoveUserAverageTest < ApplicationSystemTestCase
  setup do
    @user = User.new(email: 'test@uwaterloo.ca', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac', lastname: 'Efron', is_admin: false)
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
    @user.teams << @team
    @user.save

    @feedback = Feedback.new(rating: 4, comments: "This team is disorganized", priority: 4, goal_rating: 4, communication_rating: 4, positive_rating: 4, reach_rating: 4, bounce_rating: 4, account_rating: 4, decision_rating: 4, respect_rating: 4, progress_comments: "Test progress", motivation_rating: 4 )
    @feedback.timestamp = @feedback.format_time(DateTime.now)
    @feedback.user = @user
    @feedback.team = @user.teams.first
  end 


  #def test click on for rating, sorting functionality is tested in model test  
  def test_dashboard_instructor
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    click_on 'Test Team', :match => :first
    click_on 'Remove User From Team'

    click_on 'Remove User'

    assert_text '10'
    
  end 

    
end

