class NotificationsController < ApplicationController
  def index
    current_notifications = current_user.passive_notifications
    @notifications = current_notifications.where.not(visitor_id: current_user.id)
  end
  
  def update
    # notification = Notification.find(params[:id]) 
  # binding.pry 
    notification=Notification.find(params[:format]) #...①
    
    if notification.update(checked: true) 
      redirect_to action: :index
    end
  end
end
