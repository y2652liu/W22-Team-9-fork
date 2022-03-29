require "application_system_test_case"

# Acceptance Criteria:
# 1. As a student when submitting feedback before deadline but others hasn't submit yet, I should not see the average display on my dashboard.
# 2. As a student when submitting feedback before deadline but others hasn't submit yet, I should not see the average display on view historical feedback.
# 3. As an instructor when submitting feedback before deadline but others hasn't submit yet, I should not see the average display on my dashboard.
# 4. As an instructor when submitting feedback before deadline but others hasn't submit yet, I should not see the average display on manage team page.

class EntireTeamSubmitsTest < ApplicationSystemTestCase
    setup do
      @user = User.new(email: 'test@gmail.com', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zac', lastname: 'Efron', is_admin: false)
      @user2 = User.new(email: 'test2@gmail.com', password: 'asdasd', password_confirmation: 'asdasd', name: 'Zactwo', lastname: 'Efrontwo', is_admin: false)
      
      @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
      @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
      @user.teams << @team
      @user.save
      @user2.teams << @team
      @user2.save
    end 
      
    def test_student_dashboard
      visit root_url
      login 'test@gmail.com', 'asdasd'
      assert_current_path root_url
    
      click_on "Submit for"
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
      fill_in 'feedback_comments', :with => 'i love this team'
      click_on "Create Feedback"
      assert_current_path root_url
      
      #averge should not show on student dashboard
      #(10.0+0)/2=5.0
      assert_no_text "5.0"
    end

    def test_student_view_history
      visit root_url
      login 'test@gmail.com', 'asdasd'
      assert_current_path root_url
    
      click_on "Submit for"
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
      fill_in 'feedback_comments', :with => 'i love this team'
      click_on "Create Feedback"
      assert_current_path root_url
      click_on "View Historical Data"

      #averge should not show on student view history
      #(10.0+0)/2=5.0
      assert_no_text "5.0"

    end

    def test_instructor_dashboard
        visit root_url
        login 'msmucker@gmail.com', 'professor'
        assert_current_path root_url
      
        #averge should not show on instrcuctor dashboard
        #(10.0+0)/2=5.0
        assert_no_text "5.0"
      end
    
    def test_instructor_manage_team
        visit root_url
        login 'msmucker@gmail.com', 'professor'
        assert_current_path root_url
      
        #averge should not show on instrcuctor manage team
        #(10.0+0)/2=5.0
        click_on "Test Team"
        assert_no_text "5.0"
    end


    def test_student_dashboard_all_submitted
        visit root_url
        login 'test2@gmail.com', 'asdasd'
        assert_current_path root_url
      
        click_on "Submit for"
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
        fill_in 'feedback_comments', :with => 'i love this team'
        click_on "Create Feedback"
        assert_current_path root_url
        
        #averge should not show on student dashboard
        #(10.0+10.0)/2=10.0
        assert_text "10.0"
      end
  
      def test_student_view_history_all_submitted
        visit root_url
        login 'test@gmail.com', 'asdasd'
        assert_current_path root_url
      
        click_on "Submit for"
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
        fill_in 'feedback_comments', :with => 'i love this team'
        click_on "Create Feedback"
        assert_current_path root_url
        click_on "View Historical Data"
  
        #averge should not show on student view history
        #(10.0+0)/2=5.0
        assert_text "5.0"
  
      end
  
      def test_instructor_dashboard_all_submitted
          visit root_url
          login 'msmucker@gmail.com', 'professor'
          assert_current_path root_url
        
          #averge should not show on instrcuctor dashboard
          #(10.0+0)/2=5.0
          assert_text "5.0"
        end
      
      def test_instructor_manage_team_all_submitted
          visit root_url
          login 'msmucker@gmail.com', 'professor'
          assert_current_path root_url
        
          #averge should not show on instrcuctor manage team
          #(10.0+0)/2=5.0
          click_on "Test Team"
          assert_text "5.0"
      end
  end
  