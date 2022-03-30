# Acceptance Criteria: 
# 1. The reports tab in Instructor has disappeared

require "application_system_test_case"

# test class to ensure team code has been removed

class NoReportsSectionTest < ApplicationSystemTestCase
  def test_no_reports_tab
    # log professor in
    visit root_url
    login 'msmucker@uwaterloo.ca', 'professor'
    assert has_no_content?('Reports')


  end
end