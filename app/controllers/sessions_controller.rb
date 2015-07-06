class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :load_activities, only: [:today]
  before_action :still_logged_in, only: [:new]


  def today
    @today = Date.today
    @current_run = Run.find_by date: @today, runner: current_runner
  end

  def new
  end

  def create
    runner = Runner.find_by(email: params[:session][:email].downcase.strip)
    if runner
      if runner.authenticate(params[:session][:password])
        # Log the user in and redirect to the user's show page
        log_in runner
        redirect_to today_path
      else
        @email = params[:session][:email]
        flash.now[:danger] = "Please check your password"
        render 'new'
      end
    else
      flash.now[:danger] = "Couldn't find runner with email #{params[:session][:email]}"
      render 'new'
    end

  end

  def destroy
    log_out
    redirect_to login_path
  end


  def link_to_facebook
    facebook_user = FacebookUser.from_omniauth(request.env['omniauth.auth'])
    current_runner.facebook_user = facebook_user
    current_runner.save!
    flash[:success] = "Linked runner #{current_runner.name} to facebook profile #{facebook_user.name}"
    redirect_to root_url
  end

  def still_logged_in
    if logged_in?
      redirect_to today_path
    end
  end

  private
  def load_activities
    @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
  end

end
