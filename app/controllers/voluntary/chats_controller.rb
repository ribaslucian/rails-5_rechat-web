class Voluntary::ChatsController < Voluntary::VoluntaryController

  def private
    @contact = Contact.find params[:contact_id]

    Message.sql("
      UPDATE contacts
      SET count_views = count_views + 1 
      WHERE id = #{params[:contact_id]};
    ")
    Message.where(contact_id: params[:contact_id]).update_all(chat_open: true)
  end
  
end
