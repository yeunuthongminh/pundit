class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    respond_to do |format|
      format.json { render json: { type: 'error', message: "ABC", status: :unauthorized }}
      format.html { redirect_to root_url }
    end
  end

  def authorize_with_multiple args, query, policy
    pundit_policy = policy.new current_user, args
    unless pundit_policy.send query
      error = NotAuthorizedError.new "not allowed"
     # error.query, error.policy = query, pundit_policy

      raise error
    end
  end

  def page_params
    params.permit :controller, :action
  end
end
