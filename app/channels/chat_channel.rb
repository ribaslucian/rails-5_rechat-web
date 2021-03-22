class ChatChannel < ApplicationCable::Channel
  
  # 1
  def subscribed
    stream_from "chat_user_id_#{params[:user_id]}"
    
    u = User.find params[:user_id]
    u.chat_connected = true
    u.save!
  end

  def unsubscribed
#    puts "\nsaindo"
#    puts "\n--------------\n"
#    puts params
#    puts "\n--------------\n"
    # Any cleanup needed when channel is unsubscribed
    
    u = User.find params[:user_id]
    u.chat_connected = false
    u.save!
  end

  # 1
  def speak data
    Message.create!({
        origin_user_id: data['origin_user_id'],
        destiny_user_id: data['destiny_user_id'],
        content: data['content'],
        contact_id: data['contact_id'],
      })
    #  	Message.create! content: data['message'], room: data['room']
  end
end