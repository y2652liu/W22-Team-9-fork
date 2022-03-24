require "application_system_test_case"

# Acceptance Criteria:
# 1. Given I am on the summary page, I should be able to view all feedback submitted
# 2. I should be able to view all feedback aggregated by team

class CreateSummaryPageViewOfTeamsTest < ApplicationSystemTestCase
  setup do
    # create prof, team, and user
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    
    @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
    @team2 = Team.create(team_name: 'Test Team 2', team_code: 'TEAM02', user: @prof)
    
    @bob = User.create(email: 'bob@uwaterloo.ca', name: 'Bob', lastname: 'Kosner', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
    @bob.teams << @team
    
    @andy = User.create(email: 'andy@uwaterloo.ca', name: 'Andy', lastname: 'Polsen', is_admin: false, password: 'testpassword2', password_confirmation: 'testpassword2')
    @andy.teams << @team
    
    @sarah = User.create(email: 'sarah@uwaterloo.ca', name: 'Sarah', lastname: 'Solde', is_admin: false, password: 'testpassword3', password_confirmation: 'testpassword3')
    @sarah.teams << @team
    
    @mike = User.create(email: 'mike@uwaterloo.ca', name: 'Mike', lastname: 'Wazowski', is_admin: false, password: 'testpassword4', password_confirmation: 'testpassword4')
    @mike.teams << @team2
  end
  
  # Test all feedback can be viewed (1)
  def test_view_feedback 
    feedback = Feedback.new(rating: 2, progress_comments: "good", comments: "This team is disorganized", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    # feedback = Feedback.new(rating: 9, comments: "This team is disorganized")
    datetime = Time.current
    feedback.timestamp = feedback.format_time(datetime)
    feedback.user = @bob
    feedback.team = @bob.teams.first
    feedback.save
    
    visit root_url 
    login 'msmucker@uwaterloo.ca', 'professor'
    
    click_on "Feedback & Ratings"
    assert_current_path feedbacks_url
    assert_text "This team is disorganized"
    #assert_text "5.0"
    assert_text datetime.strftime("%Y-%m-%d %H:%M")
  end
  
  # Test feedback can be viewed, aggregated by team (2)
  def test_team_aggregated_view
    datetime = Time.zone.now
    
    #Create Bob's feedback
    feedbackBob = Feedback.new(rating: 5, progress_comments: "good", comments: "This team is OK", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    # feedbackBob = Feedback.new(rating: 5, comments: "This team is OK")
    feedbackBob.timestamp = feedbackBob.format_time(datetime)
    feedbackBob.user = @bob
    feedbackBob.team = @bob.teams.first
    feedbackBob.save
    
    feedbackAndy = Feedback.new(rating: 10, progress_comments: "good", comments: "TThis team is lovely", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    # feedbackAndy = Feedback.new(rating: 10, comments: "This team is lovely")
    feedbackAndy.timestamp = feedbackAndy.format_time(datetime)
    feedbackAndy.user = @andy
    feedbackAndy.team = @andy.teams.first
    feedbackAndy.save
    
    feedbackSarah = Feedback.new(rating: 3, progress_comments: "good", comments: "This team is horrible", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    # feedbackSarah = Feedback.new(rating: 3, comments: "This team is horrible")
    feedbackSarah.timestamp = feedbackSarah.format_time(datetime)
    feedbackSarah.user = @sarah
    feedbackSarah.team = @sarah.teams.first
    feedbackSarah.save
    
    visit root_url 
    login 'msmucker@uwaterloo.ca', 'professor'
    
    #check to see landing page summary view of team's average ratings
    assert_text "Test Team"
    # assert_text "TEAM01"
    assert_text "Bob"
    assert_text "Andy"
    assert_text "Sarah"
    assert_text "6"
    
    #checks all aggregated feedback of a team
    
    within('#' + @team.id.to_s) do 
      click_on 'Test Team'
    end
    assert_current_path team_url(@team)
    
    assert_text "Team Name: Test Team"
    assert_text "Team Code: TEAM01"
    
    #Bob's feedback

    assert_text "Bob"
    assert_text "5"
    assert_text "This team is OK"
    assert_text datetime.strftime("%Y-%m-%d %H:%M")
    
    #Andy's Feedback 

    assert_text "Andy"
    assert_text "10"
    assert_text "This team is lovely"
    
    #Sarah's Feedback

    assert_text "Sarah"
    assert_text "3"
    assert_text "This team is horrible"
  end
  
  # 4/6/2021: DEPRECATED: All teams should show link for details
  # Test case with no feedback
  #def test_team_aggregated_view_no_feedback
  #  #when a team has no feedback submitted
  #  visit root_url 
  #  login 'msmucker@uwaterloo.ca', 'professor'
  #  
  #  #check to see landing page summary view of team's average ratings
  #  assert_text "Test Team 2"
  #  assert_text "TEAM02"
  #  assert_text "Mike"
  #  assert_text "Team Does Not Have Any Ratings!"
  #end
end
