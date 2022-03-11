#This feature is archeived at this point as it allows flexible submission demo on client meeting demo.
# Acceptance Criteria: 
# 1. As a student, I am able to see the submit button from Thur.-Sun.

require "application_system_test_case"

class SubmitAfterWednesdayTest < ApplicationSystemTestCase
# I modeled this test class off of create_summary_page_view_of_teams_test.rb (mostly) created by the earlier team
    setup do
        # create prof, team, and user
        @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
        
        @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
        
        @cici = User.create(email: 'cici@gmail.com', name: 'Cici', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
        @cici.teams << @team
        
    end

    def test_submit_after_Wednesday_Thu
    # check Thursday
      new_timethu = Time.local(2022, 2, 17, 3, 0, 0)
      Timecop.freeze(new_timethu)

      visit root_url 
      login 'cici@gmail.com', 'testpassword'

      page.has_button? 'Submit for:'
    end
    
    
    # check Friday
    def test_submit_after_Wednesday_Fri
       
        new_timefri = Time.local(2022, 2, 18, 3, 0, 0)
        Timecop.freeze(new_timefri)
  
        visit root_url 
        login 'cici@gmail.com', 'testpassword'
  
        page.has_button? 'Submit for:'
    end


    # check Saturday
    def test_submit_after_Wednesday_Sat
       
        new_timesat = Time.local(2022, 2, 19, 3, 0, 0)
        Timecop.freeze(new_timesat)
      
        visit root_url 
        login 'cici@gmail.com', 'testpassword'
      
        page.has_button? 'Submit for:'
    end


    # check Sunday
    def test_submit_after_Wednesday_Sun
       
      new_timesun = Time.local(2022, 2, 20, 3, 0, 0)
      Timecop.freeze(new_timesun)
      
      visit root_url 
      login 'cici@gmail.com', 'testpassword'
      page.has_button? 'Submit for:'

     end

    # check Monday
    def test_submit_after_Wednesday_Mon
       
      new_timemon = Time.local(2022, 2, 21, 3, 0, 0)
      Timecop.freeze(new_timemon)
      
      visit root_url 
      login 'cici@gmail.com', 'testpassword'
      #refute 
      page.has_button? 'Submit for:'

    #end

    # check Tuesday
    def test_submit_after_Wednesday_Tue
       
      new_timetue = Time.local(2022, 2, 22, 3, 0, 0)
      Timecop.freeze(new_timetue)
      
      visit root_url 
      login 'cici@gmail.com', 'testpassword'
      #refute 
      page.has_button? 'Submit for:'

     
    end

    # check Wednesday
    def test_submit_after_Wednesday_Wed
       
      new_timewed = Time.local(2022, 2, 23, 3, 0, 0)
      Timecop.freeze(new_timewed)
      
      visit root_url 
      login 'cici@gmail.com', 'testpassword'
      #refute 
      page.has_button? 'Submit for:'

     
    end
  end



    
