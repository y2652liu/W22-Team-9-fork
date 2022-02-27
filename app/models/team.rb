class Team < ApplicationRecord   
  validates_length_of :team_name, maximum: 40
  validates_length_of :team_code, maximum: 26
  validates_uniqueness_of :team_code, :case_sensitive => false
  validate :code_unique
  validates_presence_of :team_name
  validates_presence_of :team_code
    
  belongs_to :user
  has_and_belongs_to_many :users
  has_many :feedbacks
  
  include FeedbacksHelper
  
  def code_unique 
    if Option.exists?(admin_code: self.team_code)
      errors.add(:team_code, 'not unique')
    end
  end

  def student_names 
    students = Array.new
    for student in self.users.to_ary
      students.push(student.name)
    end 
    return students
  end
  
  def find_priority_weighted(start_date, end_date)
    #if AT LEAST ONE of the feedbacks have a priority score of 0, meaning "urgent", the professor will see a status of "Urgent" for the respective team
    #if at least 1/3 of the feedbacks submitted have a priority score of 1, meaning "medium", the professor will see a status of "Urgent" for the respective team, used float division
    #every other case is considered a priority of low since it was the default score submitted per feedback
    #array index 0 represents number of "urgent" priorities that a team has, index 1 represents number of "medium" priorities, index 2 represents number of "low" priorities
    priority_holder = Array.new(3)
    #gets all feedbacks for a given week
    feedbacks = self.feedbacks.where(:timestamp => start_date..end_date)
    
    if feedbacks.count == 0
      return nil
    end
    
    priority_holder.each_with_index {|val, index| priority_holder[index] = feedbacks.where(priority: index).count}

    if priority_holder[0] > 0
      return "High" 
    elsif priority_holder[1] >= feedbacks.count/3.0
      return "Medium" 
    else
      return "Low"
    end 
  end 
  
  #gets the average team rating for the professor's team summary view
  def self.feedback_average_rating(feedbacks,users)
    if feedbacks.count > 0
      (feedbacks.sum{|feedback| feedback.rating}.to_f/users.size.to_f).round(2)
    else
      return nil
    end
  end
  
  #method to determine total average rating
  def avg
    feedbacks = self.feedbacks
    count = 0.0
    sum = 0.0
    feedbacks.each do |feedback|
      sum = sum +feedback.rating
      count += 1.0
    end
    if count >0
      #return sum/count
      return sum/self.users.size
    else
      return "No feedbacks yet!"
    end
  end

  #method to calculate median (References elements from m02ph3u5 on Stack Overflow: https://stackoverflow.com/questions/14859120/calculating-median-in-ruby)
  #def median
    #feedbacks = self.feedbacks
    #number_of_results = 0
    #ratings=[]
    #feedbacks.each do |feedback|
      #number_of_results = number_of_results +1
      #ratings.append(feedback.rating)
    #end 
    #if number_of_results >0
      #length = ratings.length   
      #sorted = ratings.sort
    
        #if length % 2 == 0  #checks to see if even
          
          #return (sorted[(length-1)/2.0]+sorted[(length)/2.0])/2.0
        #else
          #return sorted[(length-1)/2.0]
        #end 
    #else 
      #return "No feedbacks yet!"
    #end

  #end

  #method to calculate mode (References elements from https://medium.com/@baweaver/ruby-2-7-enumerable-tally-a706a5fb11ea on Instructions for Ruby Enumerable)
  #def mode
    #feedbacks = self.feedbacks
    #number_of_results = 0
    #ratings=[]
    #feedbacks.each do |feedback|
      #number_of_results = number_of_results +1
      #ratings.append(feedback.rating)
    #end 
    #if number_of_results >0
      #tallied = ratings.tally
      #highest_occuring_value = tallied.sort_by { |_,v| v}.last(2)
      #if highest_occuring_value.size == 1
        #highest_occuring_value [0] [0]
      #elsif highest_occuring_value [0] [1] == highest_occuring_value [1] [1]
       #return "No Mode (multiple values selected the same amount of times)"
      #else 
        #highest_occuring_value [1] [0]
      #end 
      
      # for the future, to add the number of occurrances, uncomment the following line
     # return highest_occuring_value.join(' , ') 
    #else 
      #return "No feedbacks yet!"
    #end 
  #end 
  
  # return a multidimensional array that is sorted by time (most recent first)
  # first element of each row is year and week, second element is the list of feedback
  def feedback_by_period
    periods = {}
    feedbacks = self.feedbacks
    if feedbacks.count > 0
      feedbacks.each do |feedback| 
        week = feedback.timestamp.to_date.cweek 
        year = feedback.timestamp.to_date.cwyear
        if periods.empty? || !periods.has_key?({year: year, week: week})
          periods[{year: year, week: week}] = [feedback]
        else 
          periods[{year: year, week: week}] << feedback
        end
      end
      periods.sort_by do |key, value| 
        [-key[:year], -key[:week]]
      end
    else
      nil
    end
  end
  
  def users_not_submitted(feedbacks)
    submitted = Array.new
    feedbacks.each do |feedback|
      submitted << feedback.user
    end
    self.users.to_ary - submitted
  end
  
  def current_feedback(d=now)
    current_feedback = Array.new
    self.feedbacks.each do |feedback| 
      time = feedback.timestamp.to_datetime
      if time.cweek == d.cweek && time.cwyear == d.cwyear
        current_feedback << feedback 
      end 
    end 
    current_feedback
  end 
  
  def status(start_date, end_date)
    priority = self.find_priority_weighted(start_date, end_date)
    feedbacks = self.feedbacks.where(:timestamp => start_date..end_date)
    rating = Team::feedback_average_rating(feedbacks,users)
    rating = rating.nil? ? 10 : rating
    users_not_submitted = self.users_not_submitted(feedbacks)
    users_not_submitted = self.users.to_ary.size == 0 ? 0 : users_not_submitted.size.to_f / self.users.to_ary.size
    
    if priority == 'High' or rating <= 5
      return 'red'
    elsif priority == 'Medium' or rating <= 7 or users_not_submitted >= 0.5
      return 'yellow'
    else 
      return 'green'
    end  
  end
  
  def self.generate_team_code(length = 6)
    team_code = rand(36**length).to_s(36).upcase
    
    while team_code.length != length or (Team.exists?(:team_code=>team_code) or Option.exists?(:admin_code=>team_code))
      team_code = rand(36**length).to_s(36).upcase
    end
    
    return team_code.upcase
  end
end
