class SessionsController < ApplicationController
  def new
  end

  def create
    runner = Runner.find_by(username: params[:session][:username].downcase)
    if runner && runner.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page
      log_in runner
      redirect_to runner
    else
      flash.now[:danger] = "Invalid Username/Password combination"
      render 'new'
    end

  end

  def destroy

  end
end
