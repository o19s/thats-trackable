module SessionsHelper
  # Logs in the given runner
  def log_in(runner)
    session[:runner_id] = runner.id
  end

  # Returns the current logged-in user (if any)
  def current_runner
    @current_runner ||= Runner.find_by(id: session[:runner_id]) if session[:runner_id]
  end

  def logged_in?
    !current_runner.nil?
  end

  def runner_role
    return current_runner.role
  end

  def log_out
    session.delete(:runner_id)
    @current_runner = nil
  end

  def detect_mobile
    if request.user_agent.downcase =~ /iphone|ipad/i
      return 'ios'
    elsif request.user_agent.downcase =~ /android/i
      return 'android'
    else
      return 'desktop'
    end
  end
end
