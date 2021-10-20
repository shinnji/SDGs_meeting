class NotificationsController < ApplicationController
  def index
    current_notifications = current_user.passive_notifications
    @notifications = current_notifications.where.not(visitor_id: current_user.id)
  end
end
