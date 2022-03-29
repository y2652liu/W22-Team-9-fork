require "application_system_test_case"
require 'date'

# Acceptance Criteria:
# 1. As an instructor, I would like to see each of the responses for all 10 feedback questions for each feedback entry on the /teams/:id page

class InDepthFeedbackTest < ApplicationSystemTestCase
  setup do
    @user1 = User.new(email: 'test1@uwaterloo.ca', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac1', lastname: 'Efron', is_admin: false)
    @user2 = User.new(email: 'test2@uwaterloo.ca', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac2', lastname: 'Efron', is_admin: false)
    @user3 = User.new(email: 'test3@uwaterloo.ca', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac3', lastname: 'Efron', is_admin: false)
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
    @user1.teams << @team
    @user2.teams << @team
    @user3.teams << @team
    @user1.save
    @user2.save
    @user3.save
  end 
    
  #tests features functionality
  def test_all_feedbacks_shown
    feedback1 = save_feedback(2, "feedback1", @user1, DateTime.civil_from_format(:local, 2021, 2, 15), @team, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)
    # feedback1.timestamp = feedback1.format_time(DateTime.now)
    # feedback1.user = @user1
    # feedback1.team = @user1.teams.first
    # feedback1.save

    feedback2 = save_feedback(2, "feedback2", @user2, DateTime.civil_from_format(:local, 2021, 2, 15), @team, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)
    
    feedback3 = save_feedback(2, "feedback3", @user3, DateTime.civil_from_format(:local, 2021, 2, 15), @team, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)
    

    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    click_on 'Test Team', :match => :first
    click_on 'In Depth'
    assert_text 'feedback1'
    assert_text 'feedback2'
    assert_text 'feedback3'
    assert_text "In Depth Look at Test Team's Feedback"
    assert_text "Goal Rating", count: 4
    assert_text "Bounce Rating", count: 4
    
  end 


  #ensures sutdents do not have acess
  def test_student_no_access
    visit root_url
    login 'test1@uwaterloo.ca', 'asdasd'
    click_on 'Test Team', :match => :first
    assert_no_text 'In Depth'
  end 


  #Sad path of no one having submitted
  def test_no_feedbacks
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    click_on 'Test Team', :match => :first
    click_on 'In Depth'

  end

  #Test with no members on team
  def test_no_members
    @team = Team.create(team_name: 'Test Team1', team_code: 'TEAMED', user: @prof)
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    click_on 'Test Team1', :match => :first
    click_on 'In Depth'

    assert_text "In Depth Look at Test Team1's Feedback"
    assert_text "Goal Rating", count: 1
    assert_text "Bounce Rating", count: 1
  end
  
end

