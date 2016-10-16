module ApplicationHelper
  def policy_params controller, action
    Hash[:controller, controller, :action, action, :session, session[:user_permissions]]
  end
end
