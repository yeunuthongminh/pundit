class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def has_role? role_name
    self.roles.map(&:name).include? role_name
  end

  def permissions
    @permissions = []
    self.roles.each do |role|
      @permissions += role.permissions.pluck(:model_class, :action)
    end
    @permissions.uniq
  end

  def has_permission? args
    permissions.include? args
  end
end
