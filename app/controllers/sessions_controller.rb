class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :load_activities, only: [:today]


  def today
    @today = Date.today
    @current_run = Run.find_by date: @today, runner: current_runner
  end  

  def new
  end

  def create
    runner = Runner.find_by(email: params[:session][:email].downcase.strip)
    if runner && runner.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page
      log_in runner
      # redirect_to controller: "runners", action: "today" ##.../today
      redirect_to today_path
    else
      flash.now[:danger] = "Invalid Email/Password combination"
      render 'new'
    end

  end

  def destroy
    log_out
    redirect_to login_path
  end

  private
  def load_activities
    @activities = PublicActivity::Activity.order('created_at DESC').limit(20)      
  end     
end
