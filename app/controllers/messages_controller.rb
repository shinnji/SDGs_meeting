class MessagesController < ApplicationController
    before_action :authenticate_user!, :only => [:create]

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
      @room=@message.room
      #追加
    if @message.save
      @roommembernotme=Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
      @theid=@roommembernotme.find_by(room_id: @room.id)
      notification = current_user.active_notifications.new(
      room_id: @room.id,
      message_id: @message.id,
      visited_id: @theid.user_id,
      visitor_id: current_user.id,
      action: 'dm'
      )
    # 自分の投稿に対するコメントの場合は、通知済みとする
     if notification.visitor_id == notification.visited_id
      notification.checked = true
     end
      notification.save if notification.valid?
      redirect_to "/rooms/#{@message.room_id}"
    end 
      #追加
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
