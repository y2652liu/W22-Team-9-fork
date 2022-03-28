require "application_system_test_case"

# Acceptance Criteria
# 1. As a professor, I will receive a delete confirmation message when I want to delete a team

class DeleteTeamConfirmMessagesTest < ApplicationSystemTestCase
  setup do 
    @prof = User.new(email: 'msmucker@uwaterloo.ca', password: 'professor', password_confirmation: 'professor', name: 'Mark', lastname: 'Smucker', is_admin: true)
    @prof.save
    @user1 = User.new(email: 'adam@uwaterloo.ca', password: '123456789', password_confirmation: '123456789', name: 'Adam', lastname: 'Traore', is_admin: false)
    @user1.save

    @team1 = Team.new(team_code: 'Code', team_name: 'Team 1')
    @team1.user = @prof
    @team1.save
    @user1.teams << @team1
  end 
  
  #(1)
  def test_get_confirm_message_when_deleting_team
    #Passes acceptance criteria 1: As a professor, I will receive a delete confirmation message when I want to delete a team
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    assert_current_path root_url
    
    click_on 'Manage Teams'
    assert_current_path teams_url 
    
    within('#team' + @team1.id.to_s) do
      assert_text 'Team 1'
      click_on 'Delete Team'
    end
    
    assert_equal 1, Team.count
    
    assert_current_path team_confirm_delete_path(@team1)
    assert_text "Confirm Delete #{@team1.team_name}"
    click_on "Delete Team"
    
    assert_current_path teams_url 
    assert_text "Team was successfully destroyed"
    assert_no_text "Team 1"
  end 
end
