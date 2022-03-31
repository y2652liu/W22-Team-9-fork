# require "application_system_test_case"

# # Acceptance Criteria:
# # 1: As a professor, I should be able to see colored indicators for team summary and detailed views
# # 2: As a student, I should be able to see colored indicators for team summary and detailed views

# class VisualIndicatorsTest < ApplicationSystemTestCase
#   setup do
#     @prof = User.create(email: 'charles@uwaterloo.ca', password: 'banana', password_confirmation: 'banana', name: 'Charles', lastname: 'Chaplin', is_admin: true)
    
#     @user1 = User.create(email: 'charles2@uwaterloo.ca', password: 'banana', password_confirmation: 'banana', name: 'Charles1', lastname: 'Chaplin1', is_admin: false)
#     @user1.save!
#     @user2 = User.create(email: 'charles3@uwaterloo.ca', password: 'banana', password_confirmation: 'banana', name: 'Charles2', lastname: 'Chaplin2', is_admin: false)
#     @user2.save!
#     @user3 = User.create(email: 'charles4@uwaterloo.ca', password: 'banana', password_confirmation: 'banana', name: 'Charles3', lastname: 'Chaplin3', is_admin: false)
#     @user3.save!
#     @team = Team.new(team_code: 'Code', team_name: 'Team 1')
#     @team.users = [@user1, @user2, @user3]
#     @team.user = @prof 
#     @team.save! 
#     @user1.teams << @team
#     @user1.save!
#     @user2.teams << @team
#     @user2.save! 
#     @user3.teams << @team
#     @user3.save!     

#     #date taken from: https://stackoverflow.com/questions/28319759/how-get-the-last-week-start-date-and-end-date-based-on-date-in-current-week-ruby
#     @feedback = save_feedback(4, "This team is disorganized", @user1, Date.today.last_week.beginning_of_week, @team, 1, "progress_comments", 4,4,4,4,4,4,4,4,4)
#     @feedback4 = save_feedback(3, "This team is disorganized", @user2, Date.today.last_week.beginning_of_week, @team, 2, "progress_comments", 3,3,3,3,3,3,3,3,3)
#     @feedback5 = save_feedback(3, "This team is disorganized", @user3, Date.today.last_week.beginning_of_week, @team, 1, "progress_comments", 3,3,3,3,3,3,3,3,3)

#     @feedback2 = save_feedback(2, "This team is disorganized", @user2, Time.zone.now, @team, 0, "progress_comments", 4,4,4,4,4,4,4,4,4)
#     @feedback3 = save_feedback(4, "This team is disorganized", @user1, Time.zone.now, @team, 0, "progress_comments", 4,4,4,4,4,4,4,4,4)

#   end 
  
#   def test_student_view 
#     visit root_url 
#     login 'charles2@uwaterloo.ca', 'banana'
    
#     # # No longer applies with new functionality
#     # within('#' + @team.id.to_s + '-status') do
#     #   assert find('.dot-beige')
#     # end
    
#     # assert find('.dot-yellow')

#     assert find(:xpath, "/html/body/table[1]/tbody/tr/td[1]/span")

#     click_on 'View Historical Data', :match => :first
 
#     # assert find('.dot-beige')
#     # assert find('.dot-yellow')
#   end
  
#   def test_professor_view 
#     visit root_url 
#     login 'charles@uwaterloo.ca', 'banana'
    
#     # No longer applies with new funtionality
#     within('#' + @team.id.to_s) do 
#       assert find('.dot-beige')
#     end 
    
#     assert find('.dot-yellow')
    
#     #match first taken from https://stackoverflow.com/questions/14513377/how-to-click-first-link-in-list-of-items-after-upgrading-to-capybara-2-0
#     click_link 'Team 1', :match => :first
    
#     assert find('.dot-beige')
#     assert find('.dot-yellow')
#   end
# end
