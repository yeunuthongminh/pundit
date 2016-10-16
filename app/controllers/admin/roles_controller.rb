class Admin::RolesController < ApplicationController
  def index
    @roles = Role.all
    authorize_with_multiple page_params, :index?, Admin::RolePolicy
  end
end
