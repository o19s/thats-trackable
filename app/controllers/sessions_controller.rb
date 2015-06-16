class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end

  def create
    runner = Runner.find_by(email: params[:session][:email].downcase.trim)
    if runner && runner.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page
      log_in runner
      # redirect_to controller: "runners", action: "today" ##.../today
      redirect_to "/runners/#{runner.id}/today" # .../runners/{runner.id}/today
    else
      flash.now[:danger] = "Invalid Email/Password combination"
      render 'new'
    end

  end

  def destroy
    log_out
    redirect_to login_path
  end
end
