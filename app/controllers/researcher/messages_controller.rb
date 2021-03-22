class Researcher::MessagesController < Researcher::ResearcherController
  
  
  
#  def index
#    
#    
#    if params[:search]
#      @messages = View::Message
#
#      if !params[:interaction_name].nil? && params[:interaction_name] != ''
#        @messages = @messages.where("(
#          interaction_name ~* '#{params[:interaction_name]}'
#          OR reference_interaction_name ~* '#{params[:interaction_name]}'
#        )#")
#      end
#
#      if !params[:content].nil? && params[:content] != ''
#        @messages = @messages.where("content ~* '#{params[:content]}'")
##        @messages = @messages.where("content ~* '#{params[:content]}'")
#      end
#
#      if !params[:user_chat].nil? && params[:user_chat] != ''
#        @messages = @messages.where("(
#          origin_user_name ~* '#{params[:user_chat]}'
#          OR destiny_user_name ~* '#{params[:user_chat]}'
#        )#")
#      end
#      
#      if !params[:origin_user_name].nil? && params[:origin_user_name] != ''
#        @messages = @messages.where("origin_user_name ~* '#{params[:origin_user_name]}'")
##        @messages = @messages.where("origin_user_name LIKE '#{params[:origin_user_name]}'")
#      end
#      
#      if !params[:destiny_user_name].nil? && params[:destiny_user_name] != ''
##        @messages = @messages.where("destiny_user_name LIKE '#{params[:destiny_user_name]}'")
#        @messages = @messages.where("destiny_user_name ~* '#{params[:destiny_user_name]}'")
#      end
#      
#      if params[:types] != []
#        @messages = @messages.where(type_acronym_id: params[:types])
#      end
#    else
#      @messages = View::Message
#    end
#    
#    @messages = @messages.order(created_at: :desc).page params[:page]
#  end
  
  def index
    set_filter
  end
  
  private
  
  def set_filter
    if params[:search]
      @messages = View::Message

      if !params[:interaction_name].nil? && params[:interaction_name] != ''
        @messages = @messages.where("(
          interaction_name LIKE '%#{params[:interaction_name]}%'
          OR reference_interaction_name LIKE '%#{params[:interaction_name]}%'
        )")
      end

      if !params[:content].nil? && params[:content] != ''
        @messages = @messages.where("content LIKE '%#{params[:content]}%'")
#        @messages = @messages.where("content ~* '#{params[:content]}'")
      end

      if !params[:user_chat].nil? && params[:user_chat] != ''
        @messages = @messages.where("(
          origin_user_name LIKE '%#{params[:user_chat]}%'
          OR destiny_user_name LIKE '%#{params[:user_chat]}%'
        )")
      end
      
      if !params[:origin_user_name].nil? && params[:origin_user_name] != ''
#        @messages = @messages.where("origin_user_name ~* '#{params[:origin_user_name]}'")
        @messages = @messages.where("origin_user_name LIKE '%#{params[:origin_user_name]}%'")
      end
      
      if !params[:destiny_user_name].nil? && params[:destiny_user_name] != ''
        @messages = @messages.where("destiny_user_name LIKE '%#{params[:destiny_user_name]}%'")
#        @messages = @messages.where("destiny_user_name ~* '#{params[:destiny_user_name]}'")
      end
      
      if params[:types] != []
        @messages = @messages.where(type_acronym_id: params[:types])
      end
    else
      @messages = View::Message
    end
    
    @messages = @messages.order(created_at: :desc).page params[:page]
  end
  
end
