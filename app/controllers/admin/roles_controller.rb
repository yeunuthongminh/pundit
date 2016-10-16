class Admin::RolesController < ApplicationController
  def index
    @roles = Role.all
    authorize_with_multiple page_params, :index?, Admin::RolePolicy
  end

  def new
    authorize_with_multiple page_params, :new?, Admin::RolePolicy
    @role = Role.new
    load_routes
  end

  def create
    authorize_with_multiple page_params, :create?, Admin::RolePolicy
    @role = Role.new role_params
    if @roles.save
      redirect_to [:admin, @role]
    else
      render :new
    end
  end

  def show
    authorize_with_multiple page_params, :show?, Admin::RolePolicy
    @role = Role.includes(:permissions).find params[:id]
    load_routes
  end

  def update
    @role = Role.find params[:id]
    authorize_with_multiple page_params, :update?, Admin::RolePolicy
    if @role.update_attributes role_params
      redirect_to admin_roles_path
    else
      render :edit
    end
  end

  private
  def role_params
    params.require(:role).permit :name, permissions_attributes: [:id, :model_class,
      :action, :_destroy]
  end

  def load_routes
    @routes = []
    temp = Rails.application.routes.set.anchored_routes.map(&:defaults)
      .reject {|route| route[:internal] || route[:controller].include?("devise")}

    temp.pluck(:controller).uniq.each do |controller|
      @routes << Hash["controller".to_sym, controller, "actions".to_sym, temp.select{|route| route[:controller] == controller}.pluck(:action).uniq]
    end
  end
end
