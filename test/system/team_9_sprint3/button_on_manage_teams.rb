# Acceptance Criteria: 
# 1. Teams should be sorted alphabetically
# 2. Back button on Team's page
# 3. Next button on Team's page
require "application_system_test_case"

class NextButtonTest < ApplicationSystemTestCase

    #setup taken from submit_after_wednesday.rb
    setup do
        # create prof, team, and user
        @prof = User.create(email: 'msmucker@gmail.com', name: 'Mark', lastname: 'Smucker', is_admin: true, password: 'professor', password_confirmation: 'professor')
        
        @team = Team.create(team_name: 'Test Team', team_code: 'TEAM01', user: @prof)
        @team2 = Team.create(team_name: 'Test Team 2', team_code:'TEAM02', user: @prof)

        @cici = User.create(email: 'cici@gmail.com', name: 'Cici', lastname: 'Liu', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')
        @cici.teams << @team

        @mike = User.create(email: 'bob@gmail.com', name: 'Mike', lastname: 'lin', is_admin: false, password: 'testpassword', password_confirmation: 'testpassword')

        @mike.teams << @team2

    end

    # check button function
    def test_next_button
        visit root_url 
        login 'msmucker@gmail.com', 'professor'
        assert_current_path root_url

        click_on "Manage Teams"
        click_on 'Test Team'
        # verify that the user is on the test team URL
        assert_current_path team_url(id:@team.id)
        assert_text 'Test Team'
        click_on 'Next Team'
        # verify that the URL has changed to team 2 once the next team button has been clicked
        assert_current_path team_url(id:@team2.id)
        assert_text 'Test Team 2'
    end

    # check previous button function
    def test_previous_button
        visit root_url 
        login 'msmucker@gmail.com', 'professor'
        assert_current_path root_url

        click_on "Manage Teams"
        click_on 'Test Team 2'
        # verify that the user is on the test team URL
        assert_current_path team_url(id:@team2.id)
        assert_text 'Test Team 2'
        click_on 'Previous Team'
        # verify that the URL has changed to team 2 once the next team button has been clicked
        assert_current_path team_url(id:@team.id)
        assert_text 'Test Team'
    end



end
