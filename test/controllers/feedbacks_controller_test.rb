require 'test_helper'
require 'date'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new(email: 'test@uwaterloo.ca', password: '123456789', password_confirmation: '123456789', name: 'Adam', lastname: 'Bouvaird', is_admin: false)
    @user2 = User.new(email: 'test2@uwaterloo.ca', password: '123456789', password_confirmation: '123456789', name: 'Zac', lastname: 'Bouvaird', is_admin: false)
    @user3 = User.new(email: 'test3@uwaterloo.ca', password: '123456789', password_confirmation: '123456789', name: 'Charles', lastname: 'Bouvaird', is_admin: false)
    @prof = User.create(email: 'msmucker@uwaterloo.ca', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
    @user.teams << @team
    @user.save
    @user2.teams << @team
    @user2.save
    @user3.teams << @team
    @user3.save
      
    #create new feedback from student with comment and priority of 2 (low)
    @feedback = Feedback.new(rating: 4, comments: "This team is disorganized", priority: 2, goal_rating: 4, communication_rating: 4, positive_rating: 4, reach_rating: 4, bounce_rating: 4, account_rating: 4, decision_rating: 4, respect_rating: 4, progress_comments: "Test progress", motivation_rating: 4 )
    @feedback.timestamp = @feedback.format_time(DateTime.now)
    @feedback.user = @user
    @feedback.team = @user.teams.first
    
    @feedback.save
  end

  test "should get index prof" do
    #only admin user should be able to see feedbacks
    # login user
    post('/login', params: { email: 'msmucker@uwaterloo.ca', password: 'professor'})
    get feedbacks_url
    assert_response :success
  end
  
  test "should not get index student" do
    #students should now have access to the list of feedbacks. It should redirect them back to their homepage!
    post('/login', params: { email: 'test@uwaterloo.ca', password: '123456789'})
    get feedbacks_url
    assert_response :redirect
  end 

  test "should get new" do
    Option.create(reports_toggled: true, admin_code: 'ADMIN')
    # login user
    post('/login', params: { email: 'test2@uwaterloo.ca', password: '123456789'})
    
    get new_feedback_url
    assert_response :success
  end

  test "should create feedback with default priority" do
    # login user
    post('/login', params: { email: 'test3@uwaterloo.ca', password: '123456789'})
    
    assert_difference('Feedback.count') do
        #not passing in a priority value results in default value of 2, which represents low priority
        post feedbacks_url, params: { feedback: { comments: "test comment", rating: 4, goal_rating: 4, communication_rating: 4, positive_rating: 4, reach_rating: 4, bounce_rating: 4, account_rating: 4, decision_rating: 4, respect_rating: 4, progress_comments: "Test progress", motivation_rating: 4  } }
    end
    assert_redirected_to root_url
  end
  
  test "should create feedback with selected priority" do
    # login user
    post('/login', params: { email: 'test3@uwaterloo.ca', password: '123456789'})
    
    assert_difference('Feedback.count') do
        #student selects a priority of 0, meaning it's urgent
        post feedbacks_url, params: { feedback: { comments: "test comment", rating: 4, priority: 0, goal_rating: 4, communication_rating: 4, positive_rating: 4, reach_rating: 4, bounce_rating: 4, account_rating: 4, decision_rating: 4, respect_rating: 4, progress_comments: "Test progress", motivation_rating: 4 } }
    end
    assert_redirected_to root_url
  end

  test "should show feedback" do
    # login professor
    post('/login', params: { email: 'msmucker@uwaterloo.ca', password: 'professor'})
    get feedback_url(@feedback)
    assert_response :success
  end

  test "should get edit" do
    # login professor
    post('/login', params: { email: 'msmucker@uwaterloo.ca', password: 'professor'})
    get edit_feedback_url(@feedback)
    assert_response :success
  end

  test "should update feedback" do
    # login professor
    post('/login', params: { email: 'msmucker@uwaterloo.ca', password: 'professor'})
    patch feedback_url(@feedback), params: { feedback: { comments: "test comment2", rating: 2, priority: 1, goal_rating: 4, communication_rating: 4, positive_rating: 4, reach_rating: 4, bounce_rating: 4, account_rating: 4, decision_rating: 4, respect_rating: 4, progress_comments: "Test progress", motivation_rating: 4 } }
    assert_redirected_to feedback_url(@feedback)
  end

  test "should destroy feedback" do
    # login professor
    post('/login', params: { email: 'msmucker@uwaterloo.ca', password: 'professor'})
    assert_difference('Feedback.count', -1) do
      delete feedback_url(@feedback)
    end

    assert_redirected_to feedbacks_url
  end


  test "reverse sort" do
    # login professor
    post('/login', params: { email: 'msmucker@uwaterloo.ca', password: 'professor'})
    

    get(feedbacks_url, params: { order_by:'name', reverse_name: '1'})
    assert_response :success

    get(feedbacks_url, params: { order_by:'name', reverse_name: '-1'})
    assert_response :success

    get(feedbacks_url, params: { order_by:'team', reverse_team: '1'})
    assert_response :success

    get(feedbacks_url, params: { order_by:'team', reverse_team: '-1'})
    assert_response :success

    get(feedbacks_url, params: { order_by:'rating', reverse_rating: '1'})
    assert_response :success

    get(feedbacks_url, params: { order_by:'rating', reverse_rating: '-1'})
    assert_response :success

    get(feedbacks_url, params: { order_by:'priority', reverse_priority: '1'})
    assert_response :success

    get(feedbacks_url, params: { order_by:'priority', reverse_priority: '-1'})
    assert_response :success

    get(feedbacks_url, params: { order_by:'date', reverse_timestamp: '1'})
    assert_response :success

    get(feedbacks_url, params: { order_by:'date', reverse_timestamp: '-1'})
    assert_response :success
  end
end
