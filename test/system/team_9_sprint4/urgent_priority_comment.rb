require "application_system_test_case"

# Acceptance Criteria:
# 1. As a student when submitting feedback there is an error pushed out when student selects urgent priority and tries to submit the feedback form without writing a comment

class UrgentCommentsTest < ApplicationSystemTestCase
  setup do
    @user = User.new(email: 'test@uwaterloo.ca', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac', lastname: 'Efron', is_admin: false)
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
    @user.teams << @team
    @user.save
  end 
    
  def test_urgent_comments_happy
    visit root_url
    login 'test@uwaterloo.ca', 'asdasd'
    assert_current_path root_url
  
    click_on "Submit for"
    # assert_text "Current System Time: 2021/03/21 23:30" #Acceptance criteria #1
    choose('feedback[rating]', option: 4)
    choose('feedback[goal_rating]', option: 4)
    choose('feedback[communication_rating]', option: 4)
    choose('feedback[positive_rating]', option: 4)
    choose('feedback[reach_rating]', option: 4)
    choose('feedback[bounce_rating]', option: 4)
    choose('feedback[account_rating]', option: 4)
    choose('feedback[decision_rating]', option: 4)
    choose('feedback[respect_rating]', option: 4)
    choose('feedback[motivation_rating]', option: 4)
    select "Urgent - I believe my team has serious issues and needs immediate intervention.", :from => "feedback[priority]"
    fill_in 'feedback_comments', :with => 'i hate this team'
    click_on "Create Feedback"
    assert_current_path root_url
    assert_text "Feedback was successfully created" 
  end 

  def test_urgent_comments_sad
    visit root_url
    login 'test@uwaterloo.ca', 'asdasd'
    assert_current_path root_url
  
    click_on "Submit for"
    # assert_text "Current System Time: 2021/03/21 23:30" #Acceptance criteria #1
    choose('feedback[rating]', option: 4)
    choose('feedback[goal_rating]', option: 4)
    choose('feedback[communication_rating]', option: 4)
    choose('feedback[positive_rating]', option: 4)
    choose('feedback[reach_rating]', option: 4)
    choose('feedback[bounce_rating]', option: 4)
    choose('feedback[account_rating]', option: 4)
    choose('feedback[decision_rating]', option: 4)
    choose('feedback[respect_rating]', option: 4)
    choose('feedback[motivation_rating]', option: 4)
    select "Urgent - I believe my team has serious issues and needs immediate intervention.", :from => "feedback[priority]"
    click_on "Create Feedback"
    assert_text "are required for urgent priority" 
  end 
  
end

