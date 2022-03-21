require 'test_helper'
require 'date'
class FeedbackTest < ActiveSupport::TestCase
  setup do
    @user = User.new(email: 'xyz@gmail.com', password: '123456789', password_confirmation: '123456789', name: 'Gary', lastname: 'Brown', is_admin: false)
    @user1 = User.new(email: 'abc@gmail.com', password: '123456', password_confirmation: '123456', name: 'Zain', lastname: 'Malik', is_admin: false)
    @user2 = User.new(email: 'def@gmail.com', password: '678912', password_confirmation: '678912', name: 'Andrew', lastname: 'Habib', is_admin: false)
    
    @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    
    @team = Team.create(team_name: 'Test Team 1', team_code: 'TEAM_A', user: @prof)
    @user.teams << @team
    @user.save

    @team1 = Team.create(team_name: 'Test Team 2', team_code: 'TEAM_B', user: @prof)
    @user1.teams << @team1
    @user1.save

    @team2 = Team.create(team_name: 'A', team_code: 'TEAM_C', user: @prof)
    @user2.teams << @team2
    @user2.save
  end
  
  test 'valid feedback' do
    #feedback with rating and comment and priority
    feedback = Feedback.new(rating: 9, progress_comments: "good", comments: "Test Team 1", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save
    assert feedback.valid?
  end

  test 'valid feedback with optional comment' do
    #feedback with no optional comment
    feedback2 = Feedback.new(rating: 9, progress_comments: "good", goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback2.timestamp = feedback2.format_time(DateTime.now)
    feedback2.user = @user
    feedback2.team = @user.teams.first
    feedback2.save
    assert feedback2.valid?
  end
  
  test 'valid feedback default priority rating' do
    #student does not select a priority, default value 'low' is automatically selected
    feedback = Feedback.new(rating: 9, progress_comments: "good", comments: "Test Team 1", goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save
    assert feedback.valid?
  end
  
  test 'invalid feedback comment over 2048 characters' do
    #test with 2050 characters 
    feedback = Feedback.new(rating: 9, progress_comments: "good", comments: "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", goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save
    refute feedback.valid?, 'Please limit your comment to 2048 characters or less!'
    assert_not_nil feedback.errors[:comments]
  end 
  
  test 'valid feedback comment with 2048 characters' do
    #test with 2048 characters 
    feedback = Feedback.new(rating: 9, progress_comments: "good", comments: "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", goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save
    assert feedback.valid?
  end 
  
  test 'invalid feedback no rating provided' do 
    #when students do not submit a rating 
    feedback = Feedback.new(rating: nil, progress_comments: "good", comments: "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", goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save
    refute feedback.valid?, "Rating can't be blank"
    assert_not_nil feedback.errors[:rating]
  end 
  
  def test_average_rating
    user1 = User.create(email: 'charles2@gmail.com', password: 'banana', password_confirmation: 'banana', name: 'Charles1', lastname: 'Semment', is_admin: false)
    user1.save!
    team = Team.new(team_code: 'Code', team_name: 'Team 1')
    team.user = @prof 
    team.save!  
    
    ratings = [4, 4, 3, 3, 2, 2, 1, 1, 0, 0]
    #ratings = [10, 5, 7, 2, 1, 6, 9]
    feedbacks = []
    
    ratings.each do |rating|
      #feedbacks << Feedback.new(rating: rating, comments: "None", user: user1, timestamp: DateTime.now, team: team)
      feedbacks << Feedback.new(rating: rating, progress_comments: "empty", comments: "empty", priority: rating, goal_rating: rating, communication_rating: rating, positive_rating: rating, reach_rating:rating, bounce_rating: rating, account_rating: rating, decision_rating: rating, respect_rating: rating, motivation_rating: rating, user: user1, timestamp: DateTime.now, team: team)
    end 
    
    average_rating = Feedback::average_rating(feedbacks)
    assert_equal 2.00, average_rating
    #assert_in_delta((ratings.sum.to_f/ratings.count.to_f).round(2), average_rating)
  end

  def test_sort_urgency
    feedback = Feedback.new(rating: 2, progress_comments: "good", comments: "Test Team 1", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save
    
    #feedback with no optional comment
    feedback2 = Feedback.new(rating: 2, progress_comments: "good", comments: "Test Team 2", priority: 1, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback2.timestamp = feedback2.format_time(DateTime.now)
    feedback2.user = @user
    feedback2.team = @user.teams.first
    feedback2.save

    unsorted = Feedback.all
    sorted = Feedback.order_by 'priority'

    assert_equal(unsorted[1],sorted[0])
    assert_equal(feedback2,sorted[0])
  end

  #User Acceptance Criteria: Tests that the Team Name is correctly sorted in ascending order
  def test_sort_team 
    #Feedback saved for user in Team: "Test Team 1"
    feedback = Feedback.new(rating: 2, progress_comments: "good", comments: "Test Team 1", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save

    #Feedback saved for user1 in Team: "Test Team 2"
    feedback2 = Feedback.new(rating: 2, progress_comments: "good", comments: "Test Team 2", priority: 1, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback2.timestamp = feedback2.format_time(DateTime.now)
    feedback2.user = @user1
    feedback2.team = @user1.teams.first
    feedback2.save

    #Feedback saved for user2 in Team: "A"
    feedback3 = Feedback.new(rating: 2, progress_comments: "good", comments: "A", priority: 3, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback3.timestamp = feedback3.format_time(DateTime.now)
    feedback3.user = @user2
    feedback3.team = @user2.teams.first
    feedback3.save


    #Array [0, 1, 2]
    #Unsorted order: "Test Team 1", "Test Team 2", "A"
    unsorted = Feedback.all
    #Sorted order: "A", "Test Team 1", "Test Team 2" 
    sorted = Feedback.order_by 'team'

    #USER ACCEPTANCE CRITERIA VERIFICATION:

    #The user acceptance criteria is verified when the first Team is "A"
    assert_equal(unsorted[2].team,sorted[0].team)
    assert_equal(feedback3.team,sorted[0].team)

    #The user acceptance criteria is verified when the second Team is "Test Team 1"
    assert_equal(unsorted[0].team,sorted[1].team)
    assert_equal(feedback.team,sorted[1].team)

    #The user acceptance criteria is verified when the third Team is "Test Team 2" 
    assert_equal(unsorted[1].team,sorted[2].team)
    assert_equal(feedback2.team,sorted[2].team)
  end


  #Tests the correct order of feedbacks when sorted
  def test_sort_date 
    #Feedback saved for user2 in Team: "A"
    feedback3 = Feedback.new(rating: 2, progress_comments: "good", comments: "A", priority: 3, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback3.timestamp = feedback3.format_time(DateTime.now.prev_day.prev_day)
    feedback3.user = @user2
    feedback3.team = @user2.teams.first
    feedback3.save
    
    #Feedback saved for user in Team: "Test Team 1"
    feedback = Feedback.new(rating: 2, progress_comments: "good", comments: "Test Team 1", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save

    #Feedback saved for user1 in Team: "Test Team 2"
    feedback2 = Feedback.new(rating: 2, progress_comments: "good", comments: "Test Team 2", priority: 1, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback2.timestamp = feedback2.format_time(DateTime.now.prev_day)
    feedback2.user = @user1
    feedback2.team = @user1.teams.first
    feedback2.save


    
    unsorted = Feedback.all
    sorted = Feedback.order_by 'date'

    assert_equal(unsorted[1],sorted[0])
    assert_equal(feedback3,sorted[2])

    assert_equal(feedback,sorted[0])

  end

  #User Acceptance Criteria: Tests that the Student Name is correctly sorted in ascending order
  def test_sort_student_name 
    #Feedback saved for Gary in Team: "Test Team 1"
    feedback = Feedback.new(rating: 2, progress_comments: "good", comments: "Test Team 1", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save

    #Feedback saved for Zane in Team: "Test Team 2"
    feedback2 = Feedback.new(rating: 2, progress_comments: "good", comments: "Test Team 2", priority: 1, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback2.timestamp = feedback2.format_time(DateTime.now)
    feedback2.user = @user1
    feedback2.team = @user1.teams.first
    feedback2.save

    #Feedback saved for Andrew in Team: "A"
    feedback3 = Feedback.new(rating: 2, progress_comments: "good", comments: "A", priority: 3, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback3.timestamp = feedback3.format_time(DateTime.now)
    feedback3.user = @user2
    feedback3.team = @user2.teams.first
    feedback3.save

    #Array [0, 1, 2]
    #Unsorted order: "Test Team 1", "Test Team 2", "A"
    unsorted = Feedback.all
    #Sorted order: "A", "Test Team 1", "Test Team 2" 
    sorted = Feedback.order_by 'team'

    #USER ACCEPTANCE CRITERIA VERIFICATION:

    #The user acceptance criteria is verified when the first Team is "A"
    assert_equal(unsorted[2].user,sorted[0].user)
    assert_equal(feedback3.user,sorted[0].user)

    #The user acceptance criteria is verified when the second Team is "Test Team 1"
    assert_equal(unsorted[0].user,sorted[1].user)
    assert_equal(feedback.user,sorted[1].user)

    #The user acceptance criteria is verified when the third Team is "Test Team 2" 
    assert_equal(unsorted[1].user,sorted[2].user)
    assert_equal(feedback2.user,sorted[2].user)
  end

  #User Acceptance Criteria: Tests that the Rating is correctly sorted in ascending order
  def test_sort_rating
    #Rating of 4 saved for Gary in Team: "Test Team 1"
    feedback = Feedback.new(rating: 4, progress_comments: "good", comments: "Test Team 1", priority: 2, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback.timestamp = feedback.format_time(DateTime.now)
    feedback.user = @user
    feedback.team = @user.teams.first
    feedback.save

    #Rating of 0 saved for Zane in Team: "Test Team 2"
    feedback2 = Feedback.new(rating: 0, progress_comments: "good", comments: "Test Team 2", priority: 1, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback2.timestamp = feedback2.format_time(DateTime.now)
    feedback2.user = @user1
    feedback2.team = @user1.teams.first
    feedback2.save

    #Rating of 2 saved for Andrew in Team: "A"
    feedback3 = Feedback.new(rating: 2, progress_comments: "good", comments: "A", priority: 3, goal_rating: 2, communication_rating: 2, positive_rating: 2, reach_rating:2, bounce_rating: 2, account_rating: 2, decision_rating: 2, respect_rating: 2, motivation_rating: 2)
    feedback3.timestamp = feedback3.format_time(DateTime.now)
    feedback3.user = @user2
    feedback3.team = @user2.teams.first
    feedback3.save

    #Array [0, 1, 2]
    #Unsorted order: "4", "0", "2"
    unsorted = Feedback.all
    #Sorted order: "0", "2", "4" 
    sorted = Feedback.order_by 'team'

    #USER ACCEPTANCE CRITERIA VERIFICATION:

    #The user acceptance criteria is verified when the first Team is "0"
    assert_equal(unsorted[2].rating,sorted[0].rating)
    assert_equal(feedback3.rating,sorted[0].rating)

    #The user acceptance criteria is verified when the second Team is "2"
    assert_equal(unsorted[0].rating,sorted[1].rating)
    assert_equal(feedback.rating,sorted[1].rating)

    #The user acceptance criteria is verified when the third Team is "4" 
    assert_equal(unsorted[1].rating,sorted[2].rating)
    assert_equal(feedback2.rating,sorted[2].rating)
  end

end

