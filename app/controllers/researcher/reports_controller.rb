class Researcher::ReportsController < Researcher::ResearcherController

  layout 'print'
  
  def users
    @users = User.all.order :id
  end
  
  
  def bots
    @interactions = Interaction.order(created_at: :asc).all
  end
  
  
  def messages
    #@messages = View::Message.all.order(created_at: :desc)
    @messages = Message.all.order(created_at: :desc)
  end
  
end
