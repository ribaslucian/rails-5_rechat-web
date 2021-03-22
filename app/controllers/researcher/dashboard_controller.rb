class Researcher::DashboardController < Researcher::ResearcherController

  def index
    @messages = Message.all.where('interaction_id IS NULL')
  end

end