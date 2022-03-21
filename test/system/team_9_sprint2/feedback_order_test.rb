# Acceptance Criteria: 
# 1. Sort by name
# 2. Sort by urgency
# 3. Sort by team
# 4. Sort by submission time
# 5. Sort by rating
# Above can all be found and used on the feedbacks and ratings tab


require "application_system_test_case"

class FeedbackOrder < ApplicationSystemTestCase

    setup do
        @user = User.new(email: 'xyz@gmail.com', password: '123456789', password_confirmation: '123456789', name: 'Gary', lastname: 'Brown', is_admin: false)
    @user1 = User.new(email: 'abc@gmail.com', password: '123456', password_confirmation: '123456', name: 'Zain', lastname: 'Malik', is_admin: false)
    @user2 = User.new(email: 'def@gmail.com', password: '678912', password_confirmation: '678912', name: 'Andrew', lastname: 'Habib', is_admin: false)
    
    @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
    
    @team = Team.create(team_name: 'Test Team 1', team_code: 'TEAM_A', user: @prof)
    @user.teams << @team
    @user.save

    
    @user1.teams << @team
    @user1.save

    
    @user2.teams << @team
    @user2.save


        
    end

    def test_order_priority
        save_feedback(2, "hi", @user, DateTime.now, @team, 1, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)
        save_feedback(2, "hi", @user1, DateTime.now, @team, 0, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)
        save_feedback(2, "hi", @user2, DateTime.now, @team, 2, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)

        visit root_url 
        login 'msmucker@gmail.com', 'professor'
        click_on 'Feedback & Ratings'
        assert_current_path feedbacks_url
        assert_text 'Zain'
        click_on 'Priority'
        assert_text 'Zain'
    end

    def test_order_name
        save_feedback(2, "hi", @user, DateTime.now, @team, 1, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)
        save_feedback(2, "hi", @user1, DateTime.now, @team, 0, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)
        save_feedback(2, "hi", @user2, DateTime.now, @team, 2, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)

        visit root_url 
        login 'msmucker@gmail.com', 'professor'
        click_on 'Feedback & Ratings'
        assert_current_path feedbacks_url
        assert_text 'Zain'
        click_on 'Name'
        assert_text 'Zain'
    end

    def test_order_timestamp
        save_feedback(2, "hi", @user, DateTime.now, @team, 1, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)
        save_feedback(2, "hi", @user1, DateTime.now, @team, 0, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)
        save_feedback(2, "hi", @user2, DateTime.now, @team, 2, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)

        visit root_url 
        login 'msmucker@gmail.com', 'professor'
        click_on 'Feedback & Ratings'
        assert_current_path feedbacks_url
        assert_text 'Zain'
        click_on 'Timestamp'
        assert_text 'Zain'
    end

    def test_order_rating
        save_feedback(2, "hi", @user, DateTime.now, @team, 1, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)
        save_feedback(2, "hi", @user1, DateTime.now, @team, 0, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)
        save_feedback(2, "hi", @user2, DateTime.now, @team, 2, "progress_comments", 2, 2, 2, 2, 2, 2, 2, 2, 2)

        visit root_url 
        login 'msmucker@gmail.com', 'professor'
        click_on 'Feedback & Ratings'
        assert_current_path feedbacks_url
        assert_text 'Zain'
        click_on 'Rating'
        assert_text 'Zain'
    end
      
end



    
