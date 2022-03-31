require "application_system_test_case"

# Acceptance Criteria:
# 1. allows the feedback to be reversed sorted.

class RevSortTest < ApplicationSystemTestCase
  setup do
    @user = User.new(email: 'test@uwaterloo.ca', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac', lastname: 'Efron', is_admin: false)
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
    @user.teams << @team
    @user.save
  end 


  #def test click on for rating, sorting functionality is tested in model test  
  def test_rating_click
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    click_on 'Feedback & Ratings'
    click_on  'Rating'
    assert_current_path '/feedbacks?order_by=rating&reverse_rating=1'
    click_on  'Rating'
    assert_current_path '/feedbacks?order_by=rating&reverse_rating=-1'
  end 

  #def test click on for team, sorting functionality is tested in model test  
  def test_team_click
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    click_on 'Feedback & Ratings'
    click_on  'Team'
    assert_current_path '/feedbacks?order_by=team&reverse_team=1'
    click_on  'Team'
    assert_current_path '/feedbacks?order_by=team&reverse_team=-1'
  end 

  #def test click on for student name, sorting functionality is tested in model test  
  def test_student_name_click
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    click_on 'Feedback & Ratings'
    click_on  'Student Name'
    assert_current_path '/feedbacks?order_by=name&reverse_name=1'
    click_on  'Student Nam'
    assert_current_path '/feedbacks?order_by=name&reverse_name=-1'
  end 

  #def test click on for priority, sorting functionality is tested in model test  
  def test_priority_click
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    click_on 'Feedback & Ratings'
    click_on  'Priority'
    assert_current_path '/feedbacks?order_by=priority&reverse_priority=1'
    click_on  'Priority'
    assert_current_path '/feedbacks?order_by=priority&reverse_priority=-1'
  end 

  #def test click on for timestamp, sorting functionality is tested in model test  
  def test_timestamp_click
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    click_on 'Feedback & Ratings'
    click_on  'Timestamp'
    assert_current_path '/feedbacks?order_by=date&reverse_timestamp=1'
    click_on  'Timestamp'
    assert_current_path '/feedbacks?order_by=date&reverse_timestamp=-1'
  end 

  
end

