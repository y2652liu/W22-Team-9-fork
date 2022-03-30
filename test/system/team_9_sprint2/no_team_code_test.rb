
# Acceptance Criteria: 
# 1. As an instructor, team code is not visible on instructor dashboard


require "application_system_test_case"

# test class to ensure team code has been removed

class AddChangePasswordsTest < ApplicationSystemTestCase
  def test_change_password 
    # log professor in
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'

    assert has_no_content?('Team Code')
    

  end
end
