class User < ApplicationRecord
  has_secure_password
  validates_presence_of :password
    
  before_save { self.email = email.downcase }    
  validates_presence_of :email
  validates_length_of :email, maximum: 255    
  validates_uniqueness_of :email, case_sensitive: false    
  validates_format_of :email, with: /\A([^@\s]+)@uwaterloo.ca\z/i, message: "Must be a uwaterloo.ca account"
    
  validates_presence_of :name
  validates_length_of :name, maximum: 40
  validates_presence_of :lastname
  validates_length_of :lastname, maximum: 40
  validates_length_of :password, minimum: 6
  validates_presence_of :password_confirmation
  validates_uniqueness_of :email
    
  has_many :teams
  has_and_belongs_to_many :teams
  has_many :feedbacks
  
  include FeedbacksHelper
    
  def role
    if self.is_admin
      return 'Professor' 
    else 
      return 'Student'
    end
  end
    
  def team_names 
    teams = Array.new
    for team in self.teams.to_ary
      teams.push(team.team_name)
    end 
    return teams
  end

  # Checks whether given user has submitted feedback for the current week
  # returns array containing all teams that do not have feedback submitted feedback for that
  # team during the week.
  def rating_reminders()
    teams = []
    d = now
    days_till_end = days_till_end(d, d.cweek, d.cwyear)
    self.teams.each do |team|
      match = false
      team.feedbacks.where(user_id: self.id).each do |feedback|
        test_time = feedback.timestamp.to_datetime
        match = match || (test_time.cweek == d.cweek && test_time.cwyear == d.cwyear)
      end
      if !match
        teams.push team
      end
    end
    # teams
    return teams
  end
    
  def one_submission_teams()
    teams = []
    d = now
    days_till_end = days_till_end(d, d.cweek, d.cwyear)
    self.teams.each do |team|
      match = false
      team.feedbacks.where(user_id: self.id).each do |feedback|
        test_time = feedback.timestamp.to_datetime
        match = match || (test_time.cweek == d.cweek && test_time.cwyear == d.cwyear)
      end
      if match
        teams.push team
      end
    end
    # teams
    return teams
  end


  def reset_pass_with_generated (password=nil, length=8)
    
    if password != nil
      new_pass = password
    else
      new_pass = gen_new_pass(length)
    end
    
    return reset_pass new_pass
  
  end

  def gen_new_pass(length=8)
    #generating password taken from team generate_team_code  
    new_pass = rand(36**length).to_s(36).upcase
    
    while (new_pass.length != length)
      new_pass = rand(36**length).to_s(36).upcase
    end
    return new_pass
  end
  
  private
    def reset_pass(new_pass)
      #password update taken from static reset password
      if self.update(password: new_pass, password_confirmation: new_pass)
        return true
      else 
        return false
      end 
    end
  

end
