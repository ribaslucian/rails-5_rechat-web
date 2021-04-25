class Guest::UsersController < Guest::GuestController

  def login
    
    if request.post?
      #      user = User.find_by(name: params[:user][:name], password: params[:user][:password])
      username = params[:user][:name].downcase
      username = username.delete(' ')
      user = User.find_by(name: username)
      
      if user
        session[:user] = user
        
        if user.type_acronym_id == 200
          return redirect_to '/researcher'
        else
          return redirect_to '/voluntary?login=true'
        end
      end
      
      flash[:orange] = 'Não foi encontrado a combinação usuário e senha informado.'
    end
  end

  def logout
    session[:user] = nil
    redirect_to '/guest/users/login'
  end
  
  def sign_in
    @user = User.new request.params[:user]
    
    if request.post?
      
      @user.name = @user.name.downcase
      @user.name = @user.name.delete(' ')
      
      if @user.save!
        flash[:green] = 'Usuário criado com sucesso.'
        
#        Interaction.send_welcome(1, @user.id)
        
        return redirect_to '/guest/users/login'
      end
    
      flash[:red] = 'Verifique o formulário e tente novamente.'
    else
      @user.contacts.build
      @user.contacts.build
      @user.contacts.build
      
      @user.contacts[0].type_acronym_id = 600
      @user.contacts[1].type_acronym_id = 601
      @user.contacts[2].type_acronym_id = 602
      
#      return d @user.contacts
    end
  end

end
