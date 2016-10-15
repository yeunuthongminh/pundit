class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :user, through: :user_roles
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions
end
