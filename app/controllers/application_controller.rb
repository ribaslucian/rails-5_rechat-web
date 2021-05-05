class ApplicationController < ActionController::Base
  before_action :logged?

  def d param
    # do something then render view for process_one
    render json: JSON.pretty_generate(JSON.parse(param.to_json))
  end

  def logged?
#    ActiveRecord::Base.connection.execute("BEGIN TRANSACTION; END;")
    
    ## log
#    open('log/access.txt', 'a') { |f|
#    open('/home/sda3/lucian/rechat-web2/log-access.txt', 'a') { |f|
      f.puts({
          time: Time.now.strftime("%d-%m-%Y %H\h%M\m%S\s\n"),
          session: session[:user],
          route: request.env['PATH_INFO']
      }.to_json)
    }
    
    if session[:user] != nil
      if request.env['PATH_INFO'] != '/voluntary'
        session[:loaded] = true
      end
    else
      session[:loaded] = false
    end
    #    return d Message.all
    
    #    return d (%x(python scripts/polarity2.py "Minha nossa o que está acontecendo?"))
    
    #    results = Message.select('count(*)')
    #      .where(destiny_user_id: 2)
    #      .where(favorited: true)
    #      .first['count(*)']
    #    
    #    return d results
    
    return if params[:action] == 'authorize' || params[:action] == 'get_notification'
    
    if params[:contact_return]
      Message.where(contact_id: params[:contact_id]).update_all(chat_open: true)
    end
    
    #    return d Message.all
    
    #    Message.sql("UPDATE messages SET time_focus = 0;")
    #     Message.where('origin_user_id = 2 OR destiny_user_id = 2').destroy_all
    #     return d Message.order('id DESC, interaction_ids DESC').where("interaction_id IS NOT NULL AND destiny_user_id = 2").limit(1).first
    
    if params[:message_create]
      Message.seed_test
      return d Message.all.count
    end

    if params[:messages]
      return d Message.all
    end

    type_user_namespace = {
      200 => 'researcher',
      201 => 'voluntary'
    }

    # obter hirarquia do usuario
    if session[:user] != nil
      
      # verificar se o usuario existe
      if !User.exists? session[:user]['id']
        session[:user] = nil
        return redirect_to "/voluntary" 
      end
      
      user_hierarchy = type_user_namespace[session[:user]['type_acronym_id']]
    else
      user_hierarchy = 'guest'
    end

    # obter hirarquia da rota
    namespaces = controller_path.split('/')
    namespace = namespaces.first

    if namespace != user_hierarchy
      redirect_to "/#{user_hierarchy}"
    end
  end
  
end
