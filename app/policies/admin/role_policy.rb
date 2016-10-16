class Admin::RolePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  attr_reader :current_user, :controller, :action

  def initialize current_user, args
    @user = current_user
    @controller = args[:controller]
    @action = args[:action]
  end

  def index?
    @user.has_permission?([@controller, @action]) || @user.has_role?("Admin")
  end

  def show?
    @user.has_permission?([@controller, @action]) || @user.has_role?("Admin")
  end
end
