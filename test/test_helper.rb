require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  #parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all

  # Add more helper methods to be used by all tests here...
  def login(email, password)
    assert_current_path login_url
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on "Login"
  end 
  # def save_feedback(rating, progress_comments, comments, user, timestamp, team, priority)
  def save_feedback(rating, comments, user, timestamp, team, priority, progress_comments, goal_rating, communication_rating, positive_rating, reach_rating, bounce_rating, account_rating, decision_rating, respect_rating, motivation_rating)
    feedback = Feedback.new(rating: rating, comments: comments, priority: priority, progress_comments: progress_comments, goal_rating: goal_rating, communication_rating: communication_rating, positive_rating: positive_rating, reach_rating: reach_rating, bounce_rating: bounce_rating, account_rating: account_rating, decision_rating: decision_rating, respect_rating: respect_rating, motivation_rating: motivation_rating)
    feedback.user = user
    #new
    user.feedbacks.append(feedback)
    team.feedbacks.append(feedback)
    
    feedback.timestamp = feedback.format_time(timestamp)
    feedback.team = team
    feedback.save
    feedback
  end 
end
