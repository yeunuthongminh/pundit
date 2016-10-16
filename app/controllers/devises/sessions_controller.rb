class Devises::SessionsController < Devise::SessionsController
  def create
    super
    session[:user_permissions] = current_user.permissions
  end

  def destroy
    super
    session[:user_permissions] = nil
  end
end
