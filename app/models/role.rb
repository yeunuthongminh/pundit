class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :user, through: :user_roles
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions

  accepts_nested_attributes_for :permissions, allow_destroy: true

  def permission action, model_class
    @permission = permissions.find_by action: action, model_class: model_class
    @permission.present? ? @permission.id : nil
  end
end
