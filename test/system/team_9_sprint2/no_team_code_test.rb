require "application_system_test_case"

# test class to ensure team code has been removed

class AddChangePasswordsTest < ApplicationSystemTestCase
  def test_change_password 
    # log professor in
    visit root_url
    login 'msmucker@gmail.com', 'professor'

    assert has_no_content?('Team Code')
    

  end
end
