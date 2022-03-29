class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :team

  #requires feedback to have at minimal a rating score, comments are optional 
  validates_presence_of :rating
  validates_presence_of :goal_rating
  validates_presence_of :communication_rating
  validates_presence_of :positive_rating
  validates_presence_of :reach_rating
  validates_presence_of :bounce_rating
  validates_presence_of :account_rating
  validates_presence_of :decision_rating
  validates_presence_of :respect_rating
  validates_presence_of :motivation_rating
  validates_presence_of :comments, presence: true, if: :priority_status?, message: "are required for urgent priority"
  
  #allows a max of 2048 characters for additional comments
  validates_length_of :comments, :maximum => 2048, :message => "Please limit your comment to 2048 characters or less!"
  validates_length_of :progress_comments, :maximum => 2048, :message => "Please limit your comment to 2048 characters or less!"

  def priority_status?
    self.priority == 0
  end
  
  def format_time(given_date)
  #refomats the UTC time in terms if YYYY/MM?DD HH:MM
      #current_time = given_date.in_time_zone('Eastern Time (US & Canada)').strftime('%Y/%m/%d %H:%M')
      current_time = given_date.strftime('%Y/%m/%d %H:%M')
      return current_time
  end
  
  # takes list of feedbacks and returns average rating
  def self.average_rating(feedbacks)
    (feedbacks.sum{|feedback| feedback.overall_rating}.to_f/feedbacks.count.to_f).round(2)
  end

  def overall_rating
    all_rating=(rating+goal_rating+communication_rating+positive_rating+reach_rating+bounce_rating+account_rating+decision_rating+respect_rating+motivation_rating).to_f/10.0
    return all_rating.round(2)
  end

  def self.order_by field
    if field == 'priority'
      return Feedback.order('feedbacks.priority asc')
    elsif field == 'team'
      return Feedback.find_by_sql("SELECT *
        FROM teams as t, feedbacks as f, users as u
        WHERE f.team_id = t.id AND u.id = f.user_id  
        ORDER BY t.team_name asc")
    elsif field == 'date'
      return Feedback.order('feedbacks.timestamp desc')
    elsif field == 'name'
      return Feedback.find_by_sql("SELECT f.id, f.rating, f.comments, f.timestamp, f.created_at, f.updated_at, f.team_id, f.user_id, f.priority, f.goal_rating, f.communication_rating, f.positive_rating, f.reach_rating, f.bounce_rating, f.account_rating, f.decision_rating, f.respect_rating, f.progress_comments, f.motivation_rating
      FROM teams as t, feedbacks as f, users as u
      WHERE f.team_id = t.id AND u.id = f.user_id  
      ORDER BY u.name asc")
    elsif field == 'rating'
      #Used the idea of sorting by calling the method within the model: https://stackoverflow.com/questions/4055799/how-do-you-order-by-a-custom-model-method-that-has-no-attribute-in-sql
      Feedback.all.sort_by(&:overall_rating)
    end
  end

  def self.order_by_rev(field, rev)
    if field == 'priority'
      if rev == '-1'
        return Feedback.order('feedbacks.priority asc')
      else
        return Feedback.order('feedbacks.priority desc')
      end
    elsif field == 'team'
      if rev == '-1'
        return Feedback.find_by_sql("SELECT *
          FROM teams as t, feedbacks as f, users as u
          WHERE f.team_id = t.id AND u.id = f.user_id  
          ORDER BY t.team_name asc")
      else
        return Feedback.find_by_sql("SELECT *
          FROM teams as t, feedbacks as f, users as u
          WHERE f.team_id = t.id AND u.id = f.user_id  
          ORDER BY t.team_name DESC")
      end
    elsif field == 'date'
      if rev == '-1'
        return Feedback.order('feedbacks.timestamp asc')
      else
        return Feedback.order('feedbacks.timestamp desc')
      end
    elsif field == 'name'
      if rev == '-1'
        return Feedback.find_by_sql("SELECT f.id, f.rating, f.comments, f.timestamp, f.created_at, f.updated_at, f.team_id, f.user_id, f.priority, f.goal_rating, f.communication_rating, f.positive_rating, f.reach_rating, f.bounce_rating, f.account_rating, f.decision_rating, f.respect_rating, f.progress_comments, f.motivation_rating
        FROM teams as t, feedbacks as f, users as u
        WHERE f.team_id = t.id AND u.id = f.user_id  
        ORDER BY u.name asc")
      else
        return Feedback.find_by_sql("SELECT f.id, f.rating, f.comments, f.timestamp, f.created_at, f.updated_at, f.team_id, f.user_id, f.priority, f.goal_rating, f.communication_rating, f.positive_rating, f.reach_rating, f.bounce_rating, f.account_rating, f.decision_rating, f.respect_rating, f.progress_comments, f.motivation_rating
        FROM teams as t, feedbacks as f, users as u
        WHERE f.team_id = t.id AND u.id = f.user_id  
        ORDER BY u.name desc")
      end
  
    elsif field == 'rating'
      #Used the idea of sorting by calling the method within the model: https://stackoverflow.com/questions/4055799/how-do-you-order-by-a-custom-model-method-that-has-no-attribute-in-sql
      if rev == '-1'
        Feedback.all.sort_by(&:overall_rating)
      else
        Feedback.all.sort_by(&:overall_rating).reverse
      end
    end
  end

end
