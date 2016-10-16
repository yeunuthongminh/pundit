$routes = Rails.application.routes.set.anchored_routes.map(&:defaults)
  .reject {|route| route[:internal] || route[:controller].include?("devise")}
