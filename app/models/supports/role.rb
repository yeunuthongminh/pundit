class Supports::Role
  attr_reader :role

  def initialize role
    @role = role
  end

  def routes
    @routes = []
    temp = Rails.application.routes.set.anchored_routes.map(&:defaults)
      .reject {|route| route[:internal] || route[:controller].include?("devise")}

    temp.pluck(:controller).uniq.each do |controller|
      @routes << Hash["controller".to_sym, controller, "actions".to_sym, temp.select{|route| route[:controller] == controller}.pluck(:action).uniq]
    end
    @routes
  end

  def permission action, model_class
    @permission = @role.permissions.find{|p| p.action == action && p.model_class == model_class}
    @permission.present? ? @permission.id : nil
  end
end
