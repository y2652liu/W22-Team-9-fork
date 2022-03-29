class FeedbacksController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:index, :show, :destroy, :update]
  before_action :get_user_detail
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
   
      
  def get_user_detail
    @user = current_user
  end
  # GET /feedbacks
  def index

    if params[:order_by] == nil
      @feedbacks = Feedback.all
    elsif !params[:reverse_timestamp].nil?
      @feedbacks = Feedback.order_by_rev(params[:order_by], params[:reverse_timestamp])
    elsif !params[:reverse_priority].nil?
      @feedbacks = Feedback.order_by_rev(params[:order_by], params[:reverse_priority])
    elsif !params[:reverse_rating].nil?
      @feedbacks = Feedback.order_by_rev(params[:order_by], params[:reverse_rating])
    elsif !params[:reverse_team].nil?
      @feedbacks = Feedback.order_by_rev(params[:order_by], params[:reverse_team])
    elsif !params[:reverse_name].nil?
      @feedbacks = Feedback.order_by_rev(params[:order_by], params[:reverse_name])
    end
    
  end

  # GET /feedbacks/1
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  def create
      
      
    team_submissions = @user.one_submission_teams
      
    @feedback = Feedback.new(feedback_params)
    
    @feedback.timestamp = @feedback.format_time(now)
    @feedback.user = @user
    @feedback.team = @user.teams.first
    if team_submissions.include?(@feedback.team)
        redirect_to root_url, notice: 'You have already submitted feedback for this team this week.'
    elsif @feedback.save
      redirect_to root_url, notice: "Feedback was successfully created. Time created: #{@feedback.timestamp}"
    else
      render :new
    end
  end

  # PATCH/PUT /feedbacks/1
  def update
    if @feedback.update(feedback_params)
      redirect_to @feedback, notice: 'Feedback was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /feedbacks/:id
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
    redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feedback_params
      params.require(:feedback).permit(:rating, :comments, :motivation_rating, :priority, :goal_rating, :communication_rating, :positive_rating, :reach_rating, :bounce_rating, :account_rating, :decision_rating, :respect_rating, :progress_comments)
    end
end
