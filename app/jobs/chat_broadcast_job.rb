class ChatBroadcastJob < ApplicationJob
  queue_as :default

  # 1
  def perform(message)
    ActionCable.server.broadcast "chat_user_id_#{message.origin_user_id}",
      message_html: "<div id='#{message.id}' class='sub-message'>#{render_message_right(message)}</div>",
      message_record: message
    
    if (message.destiny_user_id != 0)
      ActionCable.server.broadcast "chat_user_id_#{message.destiny_user_id}",
        message_html: "<div id='#{message.id}' class='sub-message'>#{render_message_left(message)}</div>",
        message_record: message
    end
  end

  private
  
  def render_message(message)
#    ApplicationController.renderer.render(
#      partial: 'researcher/messages/message',
#      locals: { message: message }
#    )
    
    ApplicationController.renderer.render(
      partial: 'voluntary/chats/message',
      locals: { message: message }
    )
  end
  
  def render_message_left(message)
    ApplicationController.renderer.render(
      partial: 'voluntary/chats/message_left',
      locals: { message: message }
    )
  end
  
  def render_message_right(message)
    ApplicationController.renderer.render(
      partial: 'voluntary/chats/message_right',
      locals: { message: message }
    )
  end
end