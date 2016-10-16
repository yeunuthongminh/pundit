class Admin::RolePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  attr_reader :current_user, :controller, :action, :record, :session

  def initialize current_user, args
    @user = current_user
    @controller = args[:controller]
    @action = args[:action]
    @record = args[:record]
    @session = args[:session]
  end

  def index?
    @user.has_role?("Admin") || has_permission?([@controller, @action])
  end

  def new?
    @user.has_role?("Admin") || has_permission?([@controller, @action])
  end

  def create?
    @user.has_role?("Admin") || has_permission?([@controller, @action])
  end

  def show?
    @user.has_role?("Admin") || has_permission?([@controller, @action])
  end

  def update?
    @user.has_role?("Admin") || has_permission?([@controller, @action])
  end
end
