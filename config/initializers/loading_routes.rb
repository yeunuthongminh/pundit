$routes = Rails.application.routes.set.anchored_routes.map(&:defaults)
  .reject do |route|
    route[:internal] || route[:controller].include?("devise")
  end
